import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/router/app_routes.dart';

// 热播内容

class HotVideoLayoutCard extends StatelessWidget {
  const HotVideoLayoutCard(
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
              : Column(
                  children: category.data.map((VideoItem item) {
                    return GestureDetector(
                      onTap: () => {
                        Get.toNamed(AppRoutes.videoPage, arguments: {
                          'videoId': item.id,
                        })
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: width / 3,
                              height: width / 3,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              SizedBox(
                                width: width / 2,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      // top: 8.0,
                                      // start: 8.0,
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
                              SizedBox(
                                width: width / 2,
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 8.0,
                                    // start: 8.0,
                                    // end: 8.0,
                                  ),
                                  child: Text(
                                    "The video descpription descpription descpription descpription",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
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
