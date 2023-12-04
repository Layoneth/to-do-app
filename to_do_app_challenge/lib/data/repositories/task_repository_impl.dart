import 'package:to_do_app_challenge/data/datasource/basic_datasource.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final BasicDataSource basicDataSource;

  TaskRepositoryImpl(this.basicDataSource);

  @override
  Future<bool?> createTask(String description) =>
      basicDataSource.createTask(description);

  @override
  Future<bool?> deleteTask(Task task) => basicDataSource.deleteTask(task);

  @override
  Future<bool?> editTask(Task task) => basicDataSource.editTask(task);

  @override
  Future<List<Task>?>? getTasks() => basicDataSource.getTasks();

  @override
  Future<void> toggleTask(Task task) => basicDataSource.toggleTask(task);
}
