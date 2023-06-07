import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week_eleven_flutter_networking/contact.dart';

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

  void toDetails(BuildContext context, Contact contact) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactDetails(contact: contact)
    ));
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
          final contact = Contact(data?[index]);
          return ListTile(
            title: Text(contact.name.first),
            subtitle: Text(contact.cell),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.picture.thumbnail),
            ),
            onTap: () => toDetails(context, contact),
          );
        },
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final Contact contact;
  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact details"),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            image: DecorationImage(
              image: NetworkImage(contact.picture.large),
              fit: BoxFit.cover
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 2
            )
          ),
        ),
      ),
    );
  }
}


