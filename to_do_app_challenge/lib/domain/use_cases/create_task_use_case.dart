import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<bool?> createTask({required String description}) async =>
      await taskRepository.createTask(description);
}
