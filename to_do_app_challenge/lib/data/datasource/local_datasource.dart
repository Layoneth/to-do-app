import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:to_do_app_challenge/data/datasource/basic_datasource.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';

class LocalDataSource implements BasicDataSource {
  final Isar isarDb;
  LocalDataSource(this.isarDb);

  @override
  Future<List<Task>?>? getTasks() {
    try {
      final tasks = isarDb.tasks.where().findAll();
      return tasks;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool?> createTask(String description) async {
    try {
      await isarDb.writeTxn(
          () async => await isarDb.tasks.put(Task(description: description)));
      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> toggleTask(Task task) async {
    await isarDb.writeTxn(() async {
      final existingTask =
          await isarDb.tasks.where().idEqualTo(task.id).findFirst();
      existingTask?.isCompleted = !existingTask.isCompleted;
      await isarDb.tasks.put(existingTask!);
    });
  }

  @override
  Future<bool?> deleteTask(Task task) async {
    try {
      await isarDb.writeTxn(
        () async => await isarDb.tasks.delete(task.id),
      );
      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool?> editTask(Task task) async {
    try {
      await isarDb.writeTxn(() async => await isarDb.tasks.put(task));
      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
