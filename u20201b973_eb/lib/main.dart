import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u20201b973_eb/database/database.dart';
import 'package:u20201b973_eb/ui/list_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My products",
        theme: ThemeData(
            primarySwatch: Colors.lightBlue
        ),
        home: const ListProducts(fromDatabase: false,),
      ),
    );
  }
}