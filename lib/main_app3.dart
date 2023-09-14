import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app3;
  await runner.main();
}
