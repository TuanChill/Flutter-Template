# How to Create a New Module in Flutter Template

This guide describes the process of creating a new feature module in the Flutter Template project, following Clean Architecture principles with Flutter Modular for dependency injection and routing.

## Architecture Overview

The project follows Clean Architecture with three main layers:

- **Data Layer**: Handles external data sources (API, local storage)
  - `models/`: Data transfer objects (DTOs) for API responses
  - `services/`: API calls and external data interactions
  - `repositories/`: Repository implementations that handle data operations

- **Domain Layer**: Business logic and entities
  - `entities/`: Business objects that represent the domain
  - `repositories/`: Repository interfaces/contracts
  - `usecases/`: Application business logic

- **Presentation Layer**: UI and state management
  - `cubit/`: State management using Flutter Bloc
  - `pages/`: UI screens/widgets

Each feature is organized as a module with its own routing and dependencies.

## Step-by-Step Guide to Create a New Module

Let's create a new "Todo" module as an example. This module will allow users to create, read, update, and delete todo items.

### 1. Create the Feature Directory Structure

Create the following directory structure under `lib/features/todo/`:

```
lib/features/todo/
├── data/
│   ├── models/
│   │   └── todo_model.dart
│   ├── services/
│   │   └── todo_service.dart
│   └── repositories/
│       └── todo_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── todo.dart
│   ├── repositories/
│   │   └── todo_repository.dart
│   └── usecases/
│       ├── get_todos.dart
│       ├── create_todo.dart
│       ├── update_todo.dart
│       └── delete_todo.dart
├── presentation/
│   ├── cubit/
│   │   ├── todo_cubit.dart
│   │   └── todo_state.dart
│   └── pages/
│       └── todo_list_page.dart
└── todo_module.dart
```

### 2. Create Domain Entities

Start with the domain layer. Create `lib/features/todo/domain/entities/todo.dart`:

```dart
import 'package:equatable/equatable.dart';

enum TodoStatus { pending, completed }

class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.dueDate,
  });

  final String id;
  final String title;
  final String description;
  final TodoStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? dueDate;

  bool get isCompleted => status == TodoStatus.completed;
  bool get isOverdue => dueDate != null && dueDate!.isBefore(DateTime.now()) && !isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: TodoStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => TodoStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  List<Object?> get props => [id, title, description, status, createdAt, updatedAt, dueDate];
}
```

### 3. Create Domain Repository Interface

Create `lib/features/todo/domain/repositories/todo_repository.dart`:

```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../entities/todo.dart';
import '../../data/models/todo_model.dart';

abstract class TodoRepository {
  Future<ApiResponse<List<Todo>>> getTodos();
  Future<ApiResponse<Todo>> createTodo(CreateTodoRequest request);
  Future<ApiResponse<Todo>> updateTodo(String id, UpdateTodoRequest request);
  Future<ApiResponse<void>> deleteTodo(String id);
}
```

### 4. Create Domain Usecases

Create the usecase classes in `lib/features/todo/domain/usecases/`:

**get_todos.dart:**
```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos {
  const GetTodos(this._repository);

  final TodoRepository _repository;

  Future<ApiResponse<List<Todo>>> call() async {
    return await _repository.getTodos();
  }
}
```

**create_todo.dart:**
```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class CreateTodo {
  const CreateTodo(this._repository);

  final TodoRepository _repository;

  Future<ApiResponse<Todo>> call(CreateTodoRequest request) async {
    return await _repository.createTodo(request);
  }
}
```

**update_todo.dart:**
```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class UpdateTodo {
  const UpdateTodo(this._repository);

  final TodoRepository _repository;

  Future<ApiResponse<Todo>> call(String id, UpdateTodoRequest request) async {
    return await _repository.updateTodo(id, request);
  }
}
```

**delete_todo.dart:**
```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo {
  const DeleteTodo(this._repository);

  final TodoRepository _repository;

  Future<ApiResponse<void>> call(String id) async {
    return await _repository.deleteTodo(id);
  }
}
```

### 5. Create Data Models

Create `lib/features/todo/data/models/todo_model.dart` for API data transfer:

```dart
import '../../domain/entities/todo.dart';

class CreateTodoRequest {
  const CreateTodoRequest({
    required this.title,
    required this.description,
    this.dueDate,
  });

  final String title;
  final String description;
  final DateTime? dueDate;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}

class UpdateTodoRequest {
  const UpdateTodoRequest({
    required this.title,
    required this.description,
    required this.status,
    this.dueDate,
  });

  final String title;
  final String description;
  final TodoStatus status;
  final DateTime? dueDate;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status.name,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
```

### 6. Create Data Services

Create `lib/features/todo/data/services/todo_service.dart`:

```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../models/todo_model.dart';
import '../../domain/entities/todo.dart';

class TodoService {
  TodoService();

  /// Get all todos
  Future<ApiResponse<List<Todo>>> getTodos() async {
    try {
      // Mock data for demonstration
      await Future.delayed(const Duration(seconds: 1));

      final mockTodos = [
        Todo(
          id: '1',
          title: 'Complete Flutter project',
          description: 'Finish the Flutter template implementation',
          status: TodoStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          dueDate: DateTime.now().add(const Duration(days: 7)),
        ),
        Todo(
          id: '2',
          title: 'Write documentation',
          description: 'Create comprehensive documentation for the project',
          status: TodoStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      return ApiResponse.success(
        data: mockTodos,
        message: 'Todos retrieved successfully',
      );

      // Real API call would be:
      // return await _httpService.get<List<Todo>>(
      //   '/todos',
      //   fromJson: (data) => (data as List).map((e) => Todo.fromJson(e)).toList(),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to get todos: ${e.toString()}',
      );
    }
  }

  /// Create a new todo
  Future<ApiResponse<Todo>> createTodo(CreateTodoRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: request.title,
        description: request.description,
        status: TodoStatus.pending,
        createdAt: DateTime.now(),
        dueDate: request.dueDate,
      );

      return ApiResponse.success(
        data: newTodo,
        message: 'Todo created successfully',
      );

      // Real API call would be:
      // return await _httpService.post<Todo>(
      //   '/todos',
      //   data: request.toJson(),
      //   fromJson: (data) => Todo.fromJson(data),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to create todo: ${e.toString()}',
      );
    }
  }

  /// Update an existing todo
  Future<ApiResponse<Todo>> updateTodo(String id, UpdateTodoRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final updatedTodo = Todo(
        id: id,
        title: request.title,
        description: request.description,
        status: request.status,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        dueDate: request.dueDate,
      );

      return ApiResponse.success(
        data: updatedTodo,
        message: 'Todo updated successfully',
      );

      // Real API call would be:
      // return await _httpService.put<Todo>(
      //   '/todos/$id',
      //   data: request.toJson(),
      //   fromJson: (data) => Todo.fromJson(data),
      // );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to update todo: ${e.toString()}',
      );
    }
  }

  /// Delete a todo
  Future<ApiResponse<void>> deleteTodo(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return ApiResponse.success(
        data: null,
        message: 'Todo deleted successfully',
      );

      // Real API call would be:
      // return await _httpService.delete<void>('/todos/$id');
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to delete todo: ${e.toString()}',
      );
    }
  }
}
```

### 7. Create Data Repository Implementation

Create `lib/features/todo/data/repositories/todo_repository_impl.dart`:

```dart
import 'package:flutter_template/core/network/models/api_response.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this._todoService);

  final TodoService _todoService;

  @override
  Future<ApiResponse<List<Todo>>> getTodos() async {
    return await _todoService.getTodos();
  }

  @override
  Future<ApiResponse<Todo>> createTodo(CreateTodoRequest request) async {
    return await _todoService.createTodo(request);
  }

  @override
  Future<ApiResponse<Todo>> updateTodo(String id, UpdateTodoRequest request) async {
    return await _todoService.updateTodo(id, request);
  }

  @override
  Future<ApiResponse<void>> deleteTodo(String id) async {
    return await _todoService.deleteTodo(id);
  }
}
```

### 9. Create Presentation State

Create `lib/features/todo/presentation/cubit/todo_state.dart`:

```dart
part of 'todo_cubit.dart';

class TodoState extends BaseState {
  const TodoState({
    super.status,
    super.error,
    this.todos = const [],
    this.selectedTodo,
  });

  final List<Todo> todos;
  final Todo? selectedTodo;

  TodoState copyWith({
    StateStatus? status,
    AppError? error,
    List<Todo>? todos,
    Todo? selectedTodo,
  }) {
    return TodoState(
      status: status ?? this.status,
      error: error,
      todos: todos ?? this.todos,
      selectedTodo: selectedTodo ?? this.selectedTodo,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        todos,
        selectedTodo,
      ];
}
```

### 10. Create Presentation Cubit

Create `lib/features/todo/presentation/cubit/todo_cubit.dart`:

```dart
import 'package:flutter_template/core/bloc/base_state.dart';
import 'package:flutter_template/shared/models/app_error.dart';
import '../../data/models/todo_model.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/create_todo.dart';
import '../../domain/usecases/update_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodos _getTodos;
  final CreateTodo _createTodo;
  final UpdateTodo _updateTodo;
  final DeleteTodo _deleteTodo;

  TodoCubit(
    this._getTodos,
    this._createTodo,
    this._updateTodo,
    this._deleteTodo,
  ) : super(const TodoState());

  Future<void> loadTodos() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _getTodos();

      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: StateStatus.success,
          todos: response.data!,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Failed to load todos'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Failed to load todos: ${e.toString()}'),
      ));
    }
  }

  Future<void> createTodo({
    required String title,
    required String description,
    DateTime? dueDate,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final request = CreateTodoRequest(
        title: title,
        description: description,
        dueDate: dueDate,
      );

      final response = await _createTodo(request);

      if (response.success && response.data != null) {
        final updatedTodos = [...state.todos, response.data!];
        emit(state.copyWith(
          status: StateStatus.success,
          todos: updatedTodos,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Failed to create todo'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Failed to create todo: ${e.toString()}'),
      ));
    }
  }

  Future<void> updateTodo(Todo todo, {
    required String title,
    required String description,
    required TodoStatus status,
    DateTime? dueDate,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final request = UpdateTodoRequest(
        title: title,
        description: description,
        status: status,
        dueDate: dueDate,
      );

      final response = await _updateTodo(todo.id, request);

      if (response.success && response.data != null) {
        final updatedTodos = state.todos.map((t) => t.id == todo.id ? response.data! : t).toList();
        emit(state.copyWith(
          status: StateStatus.success,
          todos: updatedTodos,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Failed to update todo'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Failed to update todo: ${e.toString()}'),
      ));
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final response = await _deleteTodo(todo.id);

      if (response.success) {
        final updatedTodos = state.todos.where((t) => t.id != todo.id).toList();
        emit(state.copyWith(
          status: StateStatus.success,
          todos: updatedTodos,
        ));
      } else {
        emit(state.copyWith(
          status: StateStatus.error,
          error: AppError.validation(response.message ?? 'Failed to delete todo'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error,
        error: AppError.unknown('Failed to delete todo: ${e.toString()}'),
      ));
    }
  }

  void selectTodo(Todo? todo) {
    emit(state.copyWith(selectedTodo: todo));
  }
}
```

### 11. Create Presentation Page

Create `lib/features/todo/presentation/pages/todo_list_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/todo_cubit.dart';
import '../../domain/entities/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().loadTodos();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTodoDialog,
          ),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error?.message ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.todos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.todos.isEmpty) {
            return const Center(
              child: Text('No todos yet. Add one!'),
            );
          }

          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return TodoListItem(
                todo: todo,
                onToggle: () => _toggleTodoStatus(todo),
                onEdit: () => _showEditTodoDialog(todo),
                onDelete: () => _deleteTodo(todo),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddTodoDialog() {
    _titleController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                context.read<TodoCubit>().createTodo(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditTodoDialog(Todo todo) {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                context.read<TodoCubit>().updateTodo(
                  todo,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  status: todo.status,
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _toggleTodoStatus(Todo todo) {
    final newStatus = todo.isCompleted ? TodoStatus.pending : TodoStatus.completed;
    context.read<TodoCubit>().updateTodo(
      todo,
      title: todo.title,
      description: todo.description,
      status: newStatus,
    );
  }

  void _deleteTodo(Todo todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Todo'),
        content: Text('Are you sure you want to delete "${todo.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TodoCubit>().deleteTodo(todo);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(todo.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
```

### 12. Create the Module

Create `lib/features/todo/todo_module.dart`:

```dart
import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/todo_list_page.dart';
import 'presentation/cubit/todo_cubit.dart';
import 'data/services/todo_service.dart';

class TodoModule extends Module {
  @override
  void binds(Injector i) {
    // Data layer
    i.addSingleton<TodoService>(TodoService.new);
    i.addSingleton<TodoRepository>(TodoRepositoryImpl.new);

    // Domain layer
    i.addSingleton<GetTodos>(GetTodos.new);
    i.addSingleton<CreateTodo>(CreateTodo.new);
    i.addSingleton<UpdateTodo>(UpdateTodo.new);
    i.addSingleton<DeleteTodo>(DeleteTodo.new);

    // Presentation layer
    i.addSingleton<TodoCubit>(() => TodoCubit(
      i.get<GetTodos>(),
      i.get<CreateTodo>(),
      i.get<UpdateTodo>(),
      i.get<DeleteTodo>(),
    ));
  }

  @override
  void routes(RouteManager r) {
    r.child('/list', child: (context) => const TodoListPage());

    // Default todo route
    r.redirect('/', to: '/list');
  }
}
```

### 13. Integrate into App Module

Since all dependencies are managed within the TodoModule, you only need to add the module to the routes in `lib/app/app_module.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_template/features/authentication/auth_module.dart';
import 'package:flutter_template/features/todo/todo_module.dart'; // Add this import
import 'package:flutter_template/features/authentication/data/services/auth_service.dart';
import 'package:flutter_template/features/authentication/presentation/cubit/auth_cubit.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Auth services (simplified for Android testing)
    i.addSingleton<AuthService>(AuthService.new);
    i.addSingleton<AuthCubit>(() => AuthCubit(i.get<AuthService>()));
  }

  @override
  void routes(RouteManager r) {
    // Authentication routes
    r.module('/auth', module: AuthModule());

    // Todo routes
    r.module('/todo', module: TodoModule()); // Add this

    // Simple home route for testing
    r.child('/home', child: (context) => const SimpleHomePage());

    // Default route
    r.redirect('/', to: '/auth/login');
  }
}
```

### 14. Update Navigation

To navigate to the todo list, you can add a button in the home page or wherever appropriate:

```dart
// In SimpleHomePage or any other page
ElevatedButton(
  onPressed: () => Modular.to.navigate('/todo/list'),
  child: const Text('View Todos'),
),
```

## Summary

Following this guide, you have created a complete Todo module with:

- **Domain Layer**: `Todo` entity with business logic
- **Data Layer**: `TodoService` for API calls and `TodoModel` for request/response DTOs
- **Presentation Layer**: `TodoCubit` for state management, `TodoState` for state definition, and `TodoListPage` for UI
- **Module Integration**: `TodoModule` for routing and dependency injection, integrated into `AppModule`

The module follows Clean Architecture principles, uses Flutter Bloc for state management, and integrates seamlessly with Flutter Modular for navigation and dependency injection.

You can now access the todo list at `/todo/list` and extend it with additional features like filtering, searching, or detailed todo views.