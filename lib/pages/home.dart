import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:lottie/lottie.dart';
import 'package:surgetv/components/CardBanner.dart';
import 'package:surgetv/components/HotVideosLayoutCard.dart';
import 'package:surgetv/components/NeverMissingLayoutCard.dart';
import 'package:surgetv/components/RankingLayoutCard.dart';
import 'package:surgetv/components/RecentlyViewedLayoutCard.dart';
import 'package:surgetv/dao/home_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List dataList = [];
  bool isLoading = true;

  void _fetchData() async {
    var res = await HomeDao.home();
    if (res.result) {
      setState(() {
        dataList.addAll(res.data);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.cast),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 32,
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
      body: ListView.builder(
        itemCount: dataList.length,
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
                        videoItem: dataList[index].data[idx],
                      );
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    itemCount: dataList[index].data.length,
                  ),
                ),
              ],
            );
          } else if (index == 1) {
            return RecentlyViewedLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else if (index == 2) {
            return HotVideoLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else if (index == 3) {
            return RankingLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else if (index == 4) {
            return NeverMissingLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else if (index == 5) {
            return RankingLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else if (index == 6) {
            return NeverMissingLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          } else {
            return RecentlyViewedLayoutCard(
              dataList[index].id,
              category: dataList[index],
            );
          }
        },
      ),
    );
  }
}
