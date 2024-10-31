import 'package:get/get.dart';
import 'package:surgetv/pages/about/about_logic.dart';
import 'package:surgetv/pages/about/about_view.dart';
import 'package:surgetv/pages/discover/discover_logic.dart';
import 'package:surgetv/pages/discover/discover_view.dart';
import 'package:surgetv/pages/feedback/feedback_logic.dart';
import 'package:surgetv/pages/feedback/feedback_view.dart';
import 'package:surgetv/pages/gift/gift_view.dart';
import 'package:surgetv/pages/gift/gift_logic.dart';
import 'package:surgetv/pages/home/home_logic.dart';
import 'package:surgetv/pages/home/home_view.dart';
import 'package:surgetv/pages/index/index_logic.dart';
import 'package:surgetv/pages/index/index_view.dart';
import 'package:surgetv/pages/login/login_logic.dart';
import 'package:surgetv/pages/login/login_view.dart';
import 'package:surgetv/pages/person/coupon_dialog/coupon_dialog_logic.dart';
import 'package:surgetv/pages/person/person_view.dart';
import 'package:surgetv/pages/person/person_logic.dart';
import 'package:surgetv/pages/person/wallet_info/wallet_info_logic.dart';
import 'package:surgetv/pages/search/search_logic.dart';
import 'package:surgetv/pages/search/search_view.dart';
import 'package:surgetv/pages/setting/setting_logic.dart';
import 'package:surgetv/pages/setting/setting_view.dart';
import 'package:surgetv/pages/shop/shop_logic.dart';
import 'package:surgetv/pages/shop/shop_view.dart';
import 'package:surgetv/pages/video/video_logic.dart';
import 'package:surgetv/pages/video/video_view.dart';
import 'package:surgetv/pages/webpage/webpage_logic.dart';
import 'package:surgetv/pages/webpage/webpage_view.dart';

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
      name: AppRoutes.searchPage,
      page: () => const SearchPage(),
      binds: [
        Bind.lazyPut(() => SearchLogic()),
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
        Bind.lazyPut(() => WalletInfoLogic()),
        Bind.lazyPut(() => CouponDialogLogic()),
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
    GetPage(
      name: AppRoutes.webpagePage,
      page: () => const WebpagePage(),
      binds: [
        Bind.lazyPut(() => WebpageLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.shopPage,
      page: () => const ShopPage(),
      binds: [
        Bind.lazyPut(() => ShopLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.feedbackPage,
      page: () => const FeedbackPage(),
      binds: [
        Bind.lazyPut(() => FeedbackLogic()),
      ],
    ),
    GetPage(
      name: AppRoutes.videoPage,
      page: () => const VideoPage(),
      binds: [
        Bind.lazyPut(() => VideoLogic()),
      ],
    ),
  ];
}
