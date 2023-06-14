// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectedHabitModelAdapter extends TypeAdapter<SelectedHabitModel> {
  @override
  final int typeId = 1;

  @override
  SelectedHabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectedHabitModel(
      id: fields[0] as int,
      selectedDate: fields[1] as DateTime,
      subtitle: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedHabitModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.selectedDate)
      ..writeByte(2)
      ..write(obj.subtitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedHabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
