// search page

import 'package:flutter/material.dart';
import 'package:surgetv/components/ElevationCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedColor;
  List<String> searchHistory = <String>[];

  String? lastSearch = '';

  // 推荐列表
  List<String> recommendList = <String>[
    '光辉岁月',
    '夏目友人帐',
    '灌篮高手',
    '龙猫',
    '千与千寻',
  ];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map((color) => ListTile(
          leading: const Icon(Icons.history),
          title: Text(color),
          trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = color;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              }),
          onTap: () {
            controller.closeView(color);
            handleSelection(color);
          },
        ));
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return recommendList
        .where((color) => color.contains(input))
        .map((filteredColor) => ListTile(
              leading: const Icon(Icons.search),
              title: Text(filteredColor),
              trailing: IconButton(
                  icon: const Icon(Icons.call_missed),
                  onPressed: () {
                    controller.text = filteredColor;
                    controller.selection =
                        TextSelection.collapsed(offset: controller.text.length);
                  }),
              onTap: () {
                controller.closeView(filteredColor);
                handleSelection(filteredColor);
              },
            ));
  }

  void handleSelection(String color) {
    setState(() {
      selectedColor = color;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchAnchor.bar(
              barHintText: lastSearch,
              suggestionsBuilder: (context, controller) {
                if (controller.text.isEmpty) {
                  if (searchHistory.isNotEmpty) {
                    return getHistoryList(controller);
                  }
                  return <Widget>[
                    const Center(
                      child: Text('No search history.',
                          style: TextStyle(color: Colors.grey)),
                    )
                  ];
                }
                return getSuggestions(controller);
              },
            ),
            const SizedBox(height: 20),
            // 最近在看
            Text(
              "最近在看",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...[
              '光辉岁月',
              '夏目友人帐',
              '灌篮高手',
              '龙猫',
              '千与千寻',
            ].map(
              (e) => Text(e,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 40),
            // 大家都在追
            SizedBox(
              width: double.infinity,
              child: ElevationCard(
                elevation: 1,
                shadowColor: Colors.transparent,
                surfaceTintColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "大家都在追",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 150),
                      child: CarouselView(
                        itemSnapping: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        shrinkExtent: 100,
                        itemExtent: 120,
                        children: List<Widget>.generate(20, (index) {
                          return Center(
                            child: Text('Item $index'),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
