// 编辑精选
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/pages/video/video_view.dart';
import 'package:surgetv/router/app_routes.dart';

class RankingLayoutCard extends StatelessWidget {
  const RankingLayoutCard(
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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsetsDirectional.all(8),
      margin: const EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Column(
        children: [
          Padding(
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
                  child: Row(
                    children: category.data.map((VideoItem item) {
                      return GestureDetector(
                        onTap: () => {
                          Get.toNamed(AppRoutes.videoPage, arguments: {
                          'videoId': item.id,
                        })
                        },
                        child: SizedBox(
                          width: (width - 48) / 3,
                          // height: width,
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
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(item.img),
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
