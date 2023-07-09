import 'package:favourite/providers/form_data.dart';
import 'package:favourite/screens/add_screen.dart';
import 'package:favourite/screens/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const AddScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
        //backgroundColor: Colors.purple,
      ),
      body: x.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : ListView.builder(
              itemCount: x.length,
              itemBuilder: ((ctx, index) => ListTile(
                    leading: Icon(Icons.circle_outlined),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              PlaceInfoScren(x.elementAt(index))));
                    },
                    tileColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.4),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 0),
                      child: Text(
                        x.elementAt(index).name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  )),
            ),
      // bottomNavigationBar:
      //     BottomNavigationBar(items: const <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(icon: Icon(Icons.add)),
      // ]),
    );
  }
}
