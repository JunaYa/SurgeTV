import 'package:get/get.dart';
import 'package:surgetv/pages/about/about_logic.dart';
import 'package:surgetv/pages/about/about_view.dart';
import 'package:surgetv/pages/discover/discover_logic.dart';
import 'package:surgetv/pages/discover/discover_view.dart';
import 'package:surgetv/pages/gift/gift_view.dart';
import 'package:surgetv/pages/gift/gift_logic.dart';
import 'package:surgetv/pages/home/home_logic.dart';
import 'package:surgetv/pages/home/home_view.dart';
import 'package:surgetv/pages/index/index_logic.dart';
import 'package:surgetv/pages/index/index_view.dart';
import 'package:surgetv/pages/login/login_logic.dart';
import 'package:surgetv/pages/login/login_view.dart';
import 'package:surgetv/pages/person/person_view.dart';
import 'package:surgetv/pages/person/person_logic.dart';
import 'package:surgetv/pages/setting/setting_logic.dart';
import 'package:surgetv/pages/setting/setting_view.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.indexPage,
      page: () => const IndexPage(),
      binds: [
        Bind.lazyPut(() => IndexLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      binds: [
        Bind.lazyPut(() => HomeLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      binds: [
        Bind.lazyPut(() => LoginLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.discoverPage,
      page: () => const DiscoverPage(),
      binds: [
        Bind.lazyPut(() => DiscoverLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.giftPage,
      page: () => const GiftPage(),
      binds: [
        Bind.lazyPut(() => GiftLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.personPage,
      page: () => const PersonPage(),
      binds: [
        Bind.lazyPut(() => PersonLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.settingPage,
      page: () => const SettingPage(),
      binds: [
        Bind.lazyPut(() => SettingLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.aboutPage,
      page: () => const AboutPage(),
      binds: [
        Bind.lazyPut(() => AboutLogic()),
      ],
    ),
    
  ];
}
