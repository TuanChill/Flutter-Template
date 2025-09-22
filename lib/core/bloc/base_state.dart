import 'package:equatable/equatable.dart';
import '../../shared/models/app_error.dart';

enum StateStatus { initial, loading, success, error }

abstract class BaseState extends Equatable {
  const BaseState({
    this.status = StateStatus.initial,
    this.error,
  });

  final StateStatus status;
  final AppError? error;

  bool get isInitial => status == StateStatus.initial;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isError => status == StateStatus.error;

  @override
  List<Object?> get props => [status, error];
}
