import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  late String description;
  late bool isCompleted;

  Task({
    required this.description,
    this.isCompleted = false,
  });
}
