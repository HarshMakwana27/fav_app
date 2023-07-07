import 'package:favourite/models/place.dart';
import 'package:flutter/material.dart';

class PlaceInfoScren extends StatelessWidget {
  const PlaceInfoScren(this.place, {super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
    );
  }
}
