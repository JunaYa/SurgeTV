import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Gif Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('TextButton'),
            ),
          ],
        ),
      ),
    );
  }
}
