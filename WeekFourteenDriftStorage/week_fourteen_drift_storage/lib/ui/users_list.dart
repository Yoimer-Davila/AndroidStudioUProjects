import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_fourteen_drift_storage/database/database.dart';
import 'package:week_fourteen_drift_storage/ui/add_user.dart';
import 'package:week_fourteen_drift_storage/util/navigation.dart' as nav;
import 'package:week_fourteen_drift_storage/util/stylers.dart' as styler;

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late AppDatabase database;
  bool sort = false;

  Widget buildUser(User user) {
    return styler.withPadding(
      widget: Card(
        elevation: 2,
        child: ListTile(
          title: Text(user.name),
          subtitle: Text(user.mail),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              database.deleteUser(user.toCompanion(true)).then((value) {
                setState(() {
                });
              });
            },
          ),
          onTap: () => addUser(user: user),
        ),
      ),
      padding: styler.horVerPadding(
        vertical: 4
      )
    );
  }

  Widget buildUsers(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => buildUser(users[index]),
    );
  }

  void addUser({User? user}) async {
    var res = await nav.to(context, AddUser(user: user,));
    if(res != null && res == true) {
      setState(() {

      });
    }

  }

  int sortByName(User first, User second) => first.name.compareTo(second.name);

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User list"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort,
              color: sort ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                sort = !sort;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: database.listUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(sort) {
              snapshot.data!.sort(sortByName);
            }
            return buildUsers(snapshot.data!);
          }
          return Center(
            child: Text(snapshot.hasError ? snapshot.error.toString() : ""),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addUser(),
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
