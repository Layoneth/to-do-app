import 'package:to_do_app_challenge/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>?>? getTasks();
  Future<bool?> createTask(String description);
  Future<bool?> deleteTask(Task task);
  Future<bool?> editTask(Task task);
  Future<void> toggleTask(Task task);
}
