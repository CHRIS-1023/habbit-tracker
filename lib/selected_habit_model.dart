import 'package:hive/hive.dart';

part 'selected_habit_model.g.dart';

@HiveType(typeId: 1)
class SelectedHabitModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final DateTime selectedDate;

  SelectedHabitModel({ required this.id, required  this.selectedDate});
}
