// ignore_for_file: always_specify_types, strict_raw_type

import 'package:get/get.dart';
import '../ui/ui.dart';
part './app_routes.dart';


class AppPages {
  AppPages._();
  static final List<GetPage> pages = <GetPage>[
    GetPage(name: Routes.SPLASH, page:() => SplashScreen(), binding: SplashBinding()),
    GetPage(name: Routes.ROOM, page:() => NavigationScreen(), binding: NavigationBinding()),
  ];
}
