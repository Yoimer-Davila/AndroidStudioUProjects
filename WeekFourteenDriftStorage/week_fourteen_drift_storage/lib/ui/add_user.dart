import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_fourteen_drift_storage/database/database.dart';
import 'package:week_fourteen_drift_storage/util/converters.dart';
import 'package:week_fourteen_drift_storage/util/stylers.dart' as styler;
import 'package:week_fourteen_drift_storage/util/navigation.dart' as nav;

class AddUser extends StatefulWidget {
  final User? user;
  const AddUser({super.key, this.user});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late AppDatabase database;
  TextEditingController textName = TextEditingController();
  TextEditingController textMail = TextEditingController();

  User? get user => widget.user;
  bool get isUpdate => user != null;

  bool isValid() => textMail.text.isNotEmpty && textName.text.isNotEmpty;

  @override
  void initState() {
    if(isUpdate){
      textName.text = user!.name;
      textMail.text = user!.mail;
    }
    super.initState();
  }

  void saveUser() {
    if(isValid()) {
      if(!isUpdate){
        database.insertUser(UsersCompanion.insert(
            name: textName.text,
            mail: textMail.text
        )).then((value) => nav.back(context, true));
      } else {
        database.updateUser(
          UsersCompanion.insert(
            id: valueOf(user!.id),
            name: textName.text,
            mail: textMail.text
          )
        ).then((value) => nav.back(context, true));
      }
    }
  }

  void resetControllers() {
    textMail.text = "";
    textName.text = "";
  }

  Widget formulary() {
    return Column(
      children: [
        styler.withPadding(
          widget: TextFormField(
            controller: textName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Insert the name",
            ),
          )
        ),
        styler.withPadding(
          widget: TextFormField(
            controller: textMail,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                hintText: "Insert the mail"
            ),
          )
        ),
        ElevatedButton(
          onPressed: () => saveUser(),
          child: Text(isUpdate ? "Update" : "Save"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text("Add user"),
      ),
      body: formulary(),
    );
  }
}
