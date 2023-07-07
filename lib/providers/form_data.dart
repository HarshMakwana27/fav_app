import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Lists { name, image }

class PlaceInfoNotifier extends StateNotifier<List<Map<Lists, String>>> {
  PlaceInfoNotifier() : super([]);

  void addPlace(Lists name, String value) {
    state.add({name: value});
  }
}

final placeInfoProvider =
    StateNotifierProvider<PlaceInfoNotifier, List<Map<Lists, String>>>(
        (ref) => PlaceInfoNotifier());
