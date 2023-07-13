import 'package:favourite/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

enum Lists { name, image }

class PlaceInfoNotifier extends StateNotifier<List<Place>> {
  PlaceInfoNotifier() : super([]);

  void addPlace(String name, File image) {
    Place newPlace = Place(name: name, image: image);
    state = [newPlace, ...state];
  }
}

final placeInfoProvider = StateNotifierProvider<PlaceInfoNotifier, List<Place>>(
    (ref) => PlaceInfoNotifier());
