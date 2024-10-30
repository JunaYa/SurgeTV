import 'package:get/get.dart';

import 'search_state.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();

  void handleSelection(String color) {
    state.selectedColor.value = color;
    if (state.searchHistory.length >= 5) {
      state.searchHistory.removeLast();
    }
    state.searchHistory.insert(0, color);
  }
}
