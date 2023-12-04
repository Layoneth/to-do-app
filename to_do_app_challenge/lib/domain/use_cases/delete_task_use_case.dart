import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository taskRepository;

  DeleteTaskUseCase(this.taskRepository);

  Future<bool?> deleteTask({required Task task}) async =>
      await taskRepository.deleteTask(task);
}
