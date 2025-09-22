import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/simple_login_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // No additional binds needed - AuthCubit is in AppModule
  }

  @override
  void routes(RouteManager r) {
    r.child('/login', child: (context) => const SimpleLoginPage());

    // Default auth route
    r.redirect('/', to: '/login');
  }
}
