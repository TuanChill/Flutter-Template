import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // Add home-specific dependencies here if needed
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
