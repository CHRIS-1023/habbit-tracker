import 'package:flutter/material.dart';
import 'package:habbit_tracker/boxes.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/drawer.dart';
import 'package:habbit_tracker/habits.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Box<Map<String, dynamic>>? selectedHabitBox;

  Box getSelectedHabitsBoxForDate(DateTime date) {
    return boxDates;
  }

  Future<void> openSelectedHabitsBox() async {
    await Hive.openBox<Map<String, dynamic>>('selectedHabits');
    setState(() {
      selectedHabitBox = Hive.box<Map<String, dynamic>>('selectedHabits');
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    openSelectedHabitsBox();
    var currentDate = DateTime.now();
    var selectedHabitsBox = getSelectedHabitsBoxForDate(currentDate);

    return Scaffold(
        backgroundColor: Colors.grey[100],
        key: scaffoldKey,
        drawer: const Drawer(child: CustomDrawer()),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          title: const Text(
            'Calorie stats',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.grid_view),
          ),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000));
              },
              icon: const Icon(Icons.calendar_month_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chalenge',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: boxHabits.length,
                  itemBuilder: (context, index) {
                    Habit habit = boxHabits.getAt(index);
                    final habitData = selectedHabitsBox.get(index);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                habit.imagePath,
                              ),
                            ),
                          ),
                          title: Text(
                            habit.title,
                            style: const TextStyle(
                              wordSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            habitData != null && habitData['completed'] == true
                                ? 'Completed'
                                : 'Not started',
                            style: TextStyle(
                              color: habitData != null &&
                                      habitData['completed'] == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Image.asset('assets/fire.png'),
                          )),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}
