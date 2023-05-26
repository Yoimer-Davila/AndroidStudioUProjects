import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Image(
            image: AssetImage("assets/eminem.jpeg"),
            fit: BoxFit.fill,
            color: Colors.black54,
            colorBlendMode: BlendMode.dstATop,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const FlutterLogo(
                size: 100.0,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.lightBlue,
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 18.0
                      )
                    )
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Enter your e-mail"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Enter your password"),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        MaterialButton(
                          height: 35.0,
                          minWidth: 70.0,
                          color: Colors.lightBlueAccent,
                          textColor: Colors.white,
                          onPressed: () {

                          },
                          splashColor: Colors.black12,
                          child: const Icon(FontAwesomeIcons.rightToBracket),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
