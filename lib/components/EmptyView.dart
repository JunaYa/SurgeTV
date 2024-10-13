// empty view
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0x80444444),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.error_outline,
            size: 50,
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            '无数据',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

