import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  bool isLoading = false;

  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    _locationData = await location.getLocation();

    setState(() {
      isLoading = false;
    });

    print(_locationData.latitude);
    print(_locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.onBackground),
          ),
          child: const Text(
            "No Location selected",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isLoading
                ? const CircularProgressIndicator()
                : TextButton.icon(
                    onPressed: _getLocation,
                    icon: const Icon(Icons.location_on),
                    label: Text(
                      "Get current location",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: Text(
                "Select on map",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
