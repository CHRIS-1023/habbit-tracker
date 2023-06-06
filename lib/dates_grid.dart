import 'package:flutter/material.dart';

class DatesGrid extends StatefulWidget {
  const DatesGrid({super.key});

  @override
  State<DatesGrid> createState() => _DatesGridState();
}

class _DatesGridState extends State<DatesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, mainAxisSpacing: 12),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey[400],
          ),
        );
      },
    );
  }
}
