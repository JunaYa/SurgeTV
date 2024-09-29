import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:surgetv/components/CardBanner.dart';
import 'package:surgetv/components/RecentlyViewedLayoutCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: ListView(
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
              child: Text(
                '最近观看',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const RecentlyViewedLayoutCard(),
          ],
        ));
  }
}
