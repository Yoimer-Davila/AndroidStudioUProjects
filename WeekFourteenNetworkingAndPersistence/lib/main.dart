import 'package:flutter/material.dart';
import 'package:week_fourteen_networking_and_persistence/ui/movie_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My movies",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: const MovieList(),
    );
  }
}
