import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/auth.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/drawer.dart';
import 'package:habbit_tracker/habits.dart';
import 'package:habbit_tracker/selected_habit_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime get currentDate => DateTime.now();

  DateTime selectedDate = DateTime.now();

  List<SelectedHabitModel> selectedHabits = [];

  List<Habit> get boxHabits => Hive.box<Habit>('habits').values.toList();

  onSelectHabit(int id) {
    selectedHabitsBox
        .add(SelectedHabitModel(id: id, selectedDate: selectedDate));

    cacheSelectedHabits();
  }

  @override
  void initState() {
    super.initState();

    cacheSelectedHabits();
  }

  void cacheSelectedHabits() {
    List<SelectedHabitModel> allSelectedHabits =
        selectedHabitsBox.values.toList();

    selectedHabits = allSelectedHabits
        .where((habit) => habit.selectedDate == selectedDate)
        .toList();

    setState(() {});
  }

  bool isSelected(id) => selectedHabits.any((habit) => habit.id == id);

  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat('EEEE, MMMM d').format(currentDate);
    var formattedDate2 = DateFormat('EEEE').format(currentDate);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: scaffoldKey,
      drawer: const Drawer(child: CustomDrawer()),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: Text(
          formattedDate,
          style: const TextStyle(color: Colors.black),
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
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NotificationWidget(),
              DatePicker(
                onDateChange: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    cacheSelectedHabits();
                  });
                },
                DateTime.now().subtract(const Duration(days: 3)),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.amber,
                selectedTextColor: Colors.white,
                daysCount: 7,
                dateTextStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$formattedDate2 habit',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 180),
                itemCount: boxHabits.length,
                itemBuilder: (context, index) {
                  Habit habit = boxHabits[index];

                  return GestureDetector(
                    onTap: () => onSelectHabit(habit.id),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isSelected(habit.id)
                            ? Colors.amber[100]
                            : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          isSelected(habit.id)
                              ? const Icon(Icons.check_circle_sharp)
                              : const Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.transparent,
                                ),
                          Image.asset(
                            habit.imagePath,
                            height: 140,
                            width: 160,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 60, 0),
                            child: Text(habit.title),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(14)),
        child: const ListTile(
          visualDensity: VisualDensity(vertical: 4),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/books.jpeg'),
          ),
          title: Text(
            'Notification!',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Now is the time to read the book,\n you can change it in settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
