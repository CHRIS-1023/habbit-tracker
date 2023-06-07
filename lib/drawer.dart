import 'package:flutter/material.dart';
import 'package:habbit_tracker/auth.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/getstarted.dart';
import 'package:habbit_tracker/login.dart';

Widget buildDrawer(BuildContext context) {
  AuthService authService = AuthService();
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 50),
      children: <Widget>[
        ListTile(
          onTap: () {
            nextScreenReplace(context, const GetStarted());
          },
          leading: const Icon(Icons.grid_view_sharp),
          title: const Text('Select habit'),
        ),
        ListTile(
          onTap: () async {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                  ],
                );
              },
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.exit_to_app),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
