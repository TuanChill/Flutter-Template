import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/bootstrap.dart';
import 'package:flutter_template/core/env/app_config.dart';

void main() {
  bootstrap(Flavor.staging, () => const App());
}
