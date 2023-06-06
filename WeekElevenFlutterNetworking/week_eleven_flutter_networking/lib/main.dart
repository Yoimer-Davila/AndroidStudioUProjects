import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyContactList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyContactList extends StatefulWidget {
  const MyContactList({Key? key}) : super(key: key);

  @override
  State<MyContactList> createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  final basePath = "https://randomuser.me/api/?results=15";
  List? data;
  Future<String> makeRequest() async {
    var response = await http.get(
        Uri.parse(basePath),
        headers: {'Accept': 'application/json'}
    );
    setState(() {
      data = json.decode(response.body)['results'];
    });
    return response.body.toString();
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Networking"),
      ),
      body: ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data?[index]['name']['first']),
            subtitle: Text(data?[index]['cell']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data?[index]['picture']['thumbnail']),
            ),
          );
        },
      ),
    );
  }
}

