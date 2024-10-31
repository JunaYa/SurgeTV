import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/pages/video/video_view.dart';
import 'package:surgetv/router/app_routes.dart';

// 一定不能错过

class NeverMissingLayoutCard extends StatelessWidget {
  const NeverMissingLayoutCard(
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: category.data.map((VideoItem item) {
                    return GestureDetector(
                      onTap: () => {
                        Get.toNamed(AppRoutes.videoPage, arguments: {
                          'videoId': item.id,
                        })
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: (width - 58) / 2,
                              height: (width - 58) * 2 / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item.img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    // top: 8.0,
                                    start: 8.0,
                                    // end: 8.0,
                                  ),
                                  child: Text(
                                    item.subject,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(180, 100, 99, 99),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsetsDirectional.only(
                                    start: 8.0),
                                padding: const EdgeInsetsDirectional.only(
                                  top: 2.0,
                                  start: 6.0,
                                  end: 6.0,
                                  bottom: 2.0,
                                ),
                                child: const Text(
                                  "甜蜜",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 237, 170, 69),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
          // margin bottom
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
