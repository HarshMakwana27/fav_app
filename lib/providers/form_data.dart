import 'package:favourite/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Lists { name, image }

class PlaceInfoNotifier extends StateNotifier<List<Place>> {
  PlaceInfoNotifier() : super([]);

  void addPlace(String name) {
    Place newPlace = Place(name: name);
    state = [newPlace, ...state];
  }
}

final placeInfoProvider = StateNotifierProvider<PlaceInfoNotifier, List<Place>>(
    (ref) => PlaceInfoNotifier());
