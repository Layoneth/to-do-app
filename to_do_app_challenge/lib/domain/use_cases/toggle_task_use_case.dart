import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';

class ToggleTaskUseCase {
  final TaskRepository taskRepository;

  ToggleTaskUseCase(this.taskRepository);

  Future<void> toggleTask({required Task task}) async =>
      await taskRepository.toggleTask(task);
}
