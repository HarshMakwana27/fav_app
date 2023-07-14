import 'package:favourite/providers/form_data.dart';
import 'package:favourite/screens/add_screen.dart';
import 'package:favourite/screens/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(placeInfoProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final x = ref.watch(placeInfoProvider);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            "Favourite places",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AddScreen()));
              },
              icon: const Icon(Icons.add),
            ),
          ],
          //backgroundColor: Colors.purple,
        ),
        body: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: x.length,
                      itemBuilder: ((ctx, index) => ListTile(
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundImage: FileImage(x[index].image),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => PlaceInfoScren(
                                    x.elementAt(index),
                                  ),
                                ),
                              );
                            },
                            // tileColor: Theme.of(context)
                            //     .colorScheme
                            //     .background
                            //     .withOpacity(0.4),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 0),
                              child: Text(
                                x.elementAt(index).name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ),
                          )),
                    );
            })

        // bottomNavigationBar:
        //     BottomNavigationBar(items: const <BottomNavigationBarItem>[
        //   BottomNavigationBarItem(icon: Icon(Icons.add)),
        // ]),
        );
  }
}
