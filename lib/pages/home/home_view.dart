import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:surgetv/components/CardBanner.dart';
import 'package:surgetv/components/HotVideosLayoutCard.dart';
import 'package:surgetv/components/NeverMissingLayoutCard.dart';
import 'package:surgetv/components/RankingLayoutCard.dart';
import 'package:surgetv/components/RecentlyViewedLayoutCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:surgetv/router/app_routes.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<HomeLogic>();
    final state = Bind.find<HomeLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    final double width = MediaQuery.sizeOf(context).width;

    return GetBuilder<HomeLogic>(
      init: logic,
      builder: (logic) => Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.cast),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.searchPage);
                    },
                    icon: const Icon(Icons.search),
                  ),
                  const SizedBox(width: 16),
                  Lottie.asset(
                    "assets/lotties/gift.json",
                    height: 36,
                    width: 36,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: state.dataList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: width * 9 / 16),
                      child: Swiper(
                        itemBuilder: (BuildContext context, int idx) {
                          return BannerCard(
                            videoItem: state.dataList[index].data[idx],
                          );
                        },
                        viewportFraction: 0.8,
                        scale: 0.9,
                        itemCount: state.dataList[index].data.length,
                      ),
                    ),
                  ],
                );
              } else if (index == 1) {
                return RecentlyViewedLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else if (index == 2) {
                return HotVideoLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else if (index == 3) {
                return RankingLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else if (index == 4) {
                return NeverMissingLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else if (index == 5) {
                return RankingLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else if (index == 6) {
                return NeverMissingLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              } else {
                return RecentlyViewedLayoutCard(
                  state.dataList[index].id,
                  category: state.dataList[index],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
