import 'package:favourite/providers/form_data.dart';
import 'package:favourite/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() {
    return _AddScreenState();
  }
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final _formkey = GlobalKey<FormState>();
  var enteredName = '';

  void _onsave() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      ref.watch(placeInfoProvider.notifier).addPlace(Lists.name, enteredName);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text("Name of the place"),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Must be between 1 to 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredName = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: _onsave,
                child: const Text('Save'),
              ),
              TextButton(
                  onPressed: () {
                    _formkey.currentState!.reset();
                  },
                  child: const Text('Reset'))
            ],
          ),
        ),
      ),
    );
  }
}
