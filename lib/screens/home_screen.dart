import 'package:favourite/providers/form_data.dart';
import 'package:favourite/screens/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final x = ref.watch(placeInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite places",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: x.length,
        itemBuilder: ((ctx, index) => Card(
              child: Text(
                x.elementAt(index).values.last,
                style: const TextStyle(color: Colors.white),
              ),
            )),
      ),
      // bottomNavigationBar:
      //     BottomNavigationBar(items: const <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(icon: Icon(Icons.add)),
      // ]),
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.4),
    );
  }
}
