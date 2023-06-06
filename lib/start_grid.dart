import 'package:flutter/material.dart';
import 'package:habbit_tracker/data.dart';
import 'package:habbit_tracker/habits.dart';

class GridStart extends StatefulWidget {
  List<Habit> selectedHabits;

  GridStart({required this.selectedHabits,super.key});

  @override
  State<GridStart> createState() => _GridStartState();
}

class _GridStartState extends State<GridStart> {
  late List<Habit> habits = [];

  // Track tapped habits

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
          onTap: () {
            setState(() {
              // Toggle the selected state of the habit
              if (widget.selectedHabits.contains(habit)) {
                widget.selectedHabits.remove(habit);
              } else {
                widget.selectedHabits.add(habit);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color:
                  widget.selectedHabits.contains(habit) ? Colors.green : Colors.white,
            ),
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

  // @override
  // void dispose() {
  //   Hive.close(); // Close Hive when the widget is disposed
  //   super.dispose();
  // }
}
