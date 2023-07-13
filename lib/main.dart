import 'package:favourite/screens/home_screen.dart';
import 'package:favourite/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
