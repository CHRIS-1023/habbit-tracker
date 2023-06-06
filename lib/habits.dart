import 'package:hive_flutter/hive_flutter.dart';

part 'habits.g.dart';

@HiveType(typeId: 0)
class Habits extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String imagePath;

  Habits({required this.title, required this.imagePath});
}
