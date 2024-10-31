// 最近观看
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/pages/video/video_view.dart';
import 'package:surgetv/router/app_routes.dart';

class RecentlyViewedLayoutCard extends StatelessWidget {
  const RecentlyViewedLayoutCard(
    dataList, {
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0, start: 0.0),
              child: Text(
                category.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // category.length == 0 display empty view
          category.data.isEmpty
              ? const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('No data'),
                  ),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200, maxWidth: width),
                  child: CarouselView(
                    itemExtent: width / 3,
                    shrinkExtent: width / 3,
                    children: category.data.map((VideoItem item) {
                      return GestureDetector(
                        onTap: () => {
                          Get.toNamed(AppRoutes.videoPage, arguments: {
                            'videoId': item.id,
                          })
                        },
                        child: SizedBox(
                          width: width / 4,
                          height: width,
                          child: Card(
                            elevation: 0,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: width / 3,
                                      color: Colors.blue,
                                      child: const Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
                                      ),
                                    ),
                                    // player icon
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: const Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      top: 8.0,
                                      // start: 8.0,
                                      // end: 8.0,
                                    ),
                                    child: Text(
                                      item.subject,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
          // margin bottom
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

enum ImageInfo {
  image0('The Flow', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_1.png'),
  image1('Through the Pane', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_2.png'),
  image2('Iridescence', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_3.png'),
  image3('Sea Change', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_4.png'),
  image4('Blue Symphony', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_5.png'),
  image5('When It Rains', 'Sponsored | Season 1 Now Streaming',
      'content_based_color_scheme_6.png');

  const ImageInfo(this.title, this.subtitle, this.url);
  final String title;
  final String subtitle;
  final String url;
}
