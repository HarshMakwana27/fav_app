import 'package:favourite/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDtabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title Text,image Text)');
    },
    version: 1,
  );
  return db;
}

enum Lists { name, image }

class PlaceInfoNotifier extends StateNotifier<List<Place>> {
  PlaceInfoNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDtabase();

    final database = await db.query('user_places');
    final places = database
        .map(
          (row) => Place(
            id: row['id'] as String,
            name: row['title'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String name, File image) async {
    final appDir = await pathprovider.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);

    final copiedImage = await image.copy('${appDir.path}/$fileName');

    Place newPlace = Place(name: name, image: copiedImage);

    final db = await _getDtabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path
    });

    state = [newPlace, ...state];
  }
}

final placeInfoProvider = StateNotifierProvider<PlaceInfoNotifier, List<Place>>(
    (ref) => PlaceInfoNotifier());
