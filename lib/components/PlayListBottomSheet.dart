// 视频分集展示
import 'package:flutter/material.dart';

class PlayListBottomSheet extends StatefulWidget {
  final List<String> list;

  const PlayListBottomSheet({
    super.key,
    required this.list,
  });

  @override
  State<PlayListBottomSheet> createState() => _PlayListBottomSheetState();
}

class _PlayListBottomSheetState extends State<PlayListBottomSheet> {
  List<String>? list;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          // 评论列表
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 70),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20, // 分集接口
              itemBuilder: (BuildContext context, int index) {
                return const Text("data");
              },
            ),
          ),
        ],
      ),
    );
  }
}
