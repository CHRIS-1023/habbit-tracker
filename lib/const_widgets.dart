import 'package:flutter/material.dart';
import 'package:habbit_tracker/analytics_page.dart';
import 'package:habbit_tracker/home_page.dart';

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 16),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              nextScreenReplace(context, const HomePage());
            },
            icon: const Icon(Icons.home_rounded),
          ),
          IconButton(
              onPressed: () {
                nextScreenReplace(context, const AnalyticsPage());
              },
              icon: const Icon(Icons.bar_chart_sharp)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.auto_graph_rounded)),
          const CircleAvatar()
        ],
      ),
    );
  }
}
