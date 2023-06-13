import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/boxes.dart';
import 'package:habbit_tracker/habits.dart';
import 'package:habbit_tracker/selected_habit_model.dart';
import 'package:habbit_tracker/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(SelectedHabitModelAdapter());
  boxHabits = await Hive.openBox<Habit>('habits');
  selectedHabitsBox = await Hive.openBox<SelectedHabitModel>('selectedHabits');
  await Hive.openBox<Map<String, dynamic>>('selectedGridIndices');
  boxDates = await Hive.openBox('dates');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
