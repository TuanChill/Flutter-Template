import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/profile_page.dart';

class ProfileModule extends Module {
  @override
  void binds(Injector i) {
    // Add profile-specific dependencies here if needed
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const ProfilePage());
  }
}
