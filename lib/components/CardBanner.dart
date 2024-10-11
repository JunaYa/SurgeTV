import 'package:flutter/material.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/pages/video.dart';

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
                  "https://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPage(
                          videoItem: widget.videoItem,
                        ),
                      ),
                    );
                  },
                  child: const Text('立即播放'),
                ),
              ),
            ],
          ),
        ));
  }
}
