import 'package:flutter/material.dart';
void main() {

  runApp(const MyStatefulApp());
}

class MyStatelessApp extends StatelessWidget {

  int counter = 0;
  MyStatelessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  const Text("First Flutter Application"),
        ),
        body: Center(
          child: Text(counter.toString()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { counter++; },
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }
}

class MyStatefulApp extends StatefulWidget {
  const MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => _MyStatefulAppState();
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  const Text("First Flutter Application"),
        ),
        body: Center(
          child: Text(
            counter.toString(),
            style: const TextStyle(
              fontSize: 58,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter++;
            });
            },
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
