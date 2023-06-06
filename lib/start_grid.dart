import 'package:flutter/material.dart';
import 'package:habbit_tracker/data.dart';
import 'package:habbit_tracker/habit.dart';

class GridStart extends StatefulWidget {
  const GridStart({super.key});

  @override
  State<GridStart> createState() => _GridStartState();
}

class _GridStartState extends State<GridStart> {
  late List<Habit> habits = [];
  @override
  void initState() {
    super.initState();
    initialiseHabbits();
  }

  void initialiseHabbits() {
    for (var habit in data) {
      habits.add(Habit(title: habit['title'], imagePath: habit['image']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: habits.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemBuilder: (context, index) {
        Habit habit = habits[index];

        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14), color: Colors.white),
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      habit.imagePath,
                      height: 140,
                      width: 160,
                    ),
                  ],
                ),
                Text(habit.title)
              ],
            ),
          ),
        );
      },
    );
  }
}
