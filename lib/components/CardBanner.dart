import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/components/GradientButton.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/router/app_routes.dart';

class BannerCard extends StatefulWidget {
  const BannerCard({super.key, required this.videoItem});

  final VideoItem videoItem;

  @override
  State<BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
        height: width * 16 / 9,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: const Alignment(0.6, 0.6),
            children: <Widget>[
              Container(
                width: double.infinity,
                height: width * 16 / 9,
                color: Colors.blue,
                child: Image.network(
                  widget.videoItem.img,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: width * 6 / 16,
                  child: GradientButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 230, 87, 148),
                        Color.fromARGB(255, 233, 40, 88),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.videoPage, arguments: {
                        'videoId': widget.videoItem.id,
                      });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 24, color: Colors.white),
                        Text(
                          '立即播放',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
