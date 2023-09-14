enum Flavor {
  app1,
  app2,
  app3,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.app1:
        return 'App 1';
      case Flavor.app2:
        return 'App 2';
      case Flavor.app3:
        return 'App 3';
      default:
        return 'title';
    }
  }

}
