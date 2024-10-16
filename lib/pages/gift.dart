import 'package:flutter/material.dart';
import 'package:surgetv/components/CheckInBoard.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key, required this.title});

  final String title;

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.secondary,
        child: const Column(
          children: [
            CheckInBoard(),
          ],
        ),
      ),
    );
  }
}
