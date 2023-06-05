import 'package:flutter/material.dart';
import 'package:habbit_tracker/auth.dart';
import 'package:habbit_tracker/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
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
                                          builder: (context) => const LogIn()),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[700],
            ),
            height: 120,
            width: 400,
            child: const CircleAvatar()),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home_rounded)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.bar_chart_sharp)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.auto_graph_rounded)),
            const CircleAvatar()
          ],
        ),
      ),
    );
  }
}
