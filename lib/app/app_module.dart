import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_template/features/authentication/auth_module.dart';
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

    // Simple home route for testing
    r.child('/home', child: (context) => const SimpleHomePage());

    // Default route
    r.redirect('/', to: '/auth/login');
  }
}

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 64),
            SizedBox(height: 16),
            Text('Welcome to FLutter Template!'),
            SizedBox(height: 16),
            Text('Login successful!'),
          ],
        ),
      ),
    );
  }
}
