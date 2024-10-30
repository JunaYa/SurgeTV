import 'package:get/get.dart';

class SearchState {
  late Rx<String?> selectedColor;
  late RxList<String> searchHistory;

  late Rx<String> lastSearch;

  // 推荐列表
  late RxList<String> recommendList;

  SearchState() {
    selectedColor = Rx<String?>(null);
    searchHistory = RxList<String>([]);
    lastSearch = Rx<String>('');
    recommendList = RxList<String>([
      '光辉岁月',
      '夏目友人帐',
      '灌篮高手',
      '龙猫',
      '千与千寻',
    ]);
  }
}
