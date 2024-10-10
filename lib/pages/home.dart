import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:surgetv/components/CardBanner.dart';
import 'package:surgetv/components/HotVideosLayoutCard.dart';
import 'package:surgetv/components/NeverMissingLayoutCard.dart';
import 'package:surgetv/components/RecentlyViewedLayoutCard.dart';
import 'package:surgetv/dao/home_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: const Icon(Icons.cast),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.0),
            child: CircleAvatar(child: Icon(Icons.search)),
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
                    itemBuilder: (BuildContext context, int index) {
                      return const BannerCard();
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    itemCount: 3,
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
