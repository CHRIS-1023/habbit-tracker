import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/auth.dart';
import 'package:habbit_tracker/boxes.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/drawer.dart';
import 'package:habbit_tracker/habits.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  Set<Map<String, dynamic>> selectedGridIndices = {};

  Box<Map<String, dynamic>>? selectedGridIndicesBox;

  @override
  void initState() {
    super.initState();
    openSelectedGridIndicesBox();
  }

  Future<void> openSelectedGridIndicesBox() async {
    await Hive.openBox<Map<String, dynamic>>('selectedGridIndices');
    setState(() {
      selectedGridIndicesBox =
          Hive.box<Map<String, dynamic>>('selectedGridIndices');
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var currentDate = DateTime.now();
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(14)),
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
              ),
              DatePicker(
                onDateChange: (selectedDate) {},
                DateTime(
                  2023,
                  6,
                ),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.amber,
                selectedTextColor: Colors.white,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 180),
                  itemCount: boxHabits.length,
                  itemBuilder: (context, index) {
                    Habit habit = boxHabits.getAt(index);
                    final isSelected =
                        selectedGridIndicesBox?.containsKey(index) ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedGridIndicesBox?.delete(index);
                          } else {
                            selectedGridIndicesBox?.put(index, {
                              'index': index,
                              'completed': true,
                            });
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: isSelected ? Colors.amber[100] : Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isSelected
                                ? const Icon(Icons.check_circle_outline)
                                : const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.transparent,
                                  ),
                            Image.asset(
                              habit.imagePath,
                              height: 140,
                              width: 160,
                            ),
                            Text(habit.title)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
