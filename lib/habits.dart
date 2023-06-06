import 'package:hive/hive.dart';

part 'habits.g.dart'; // Generated Hive adapter code

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String imagePath;

  Habit({required this.title, required this.imagePath});
}
