import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.app2;
  await runner.main();
}
