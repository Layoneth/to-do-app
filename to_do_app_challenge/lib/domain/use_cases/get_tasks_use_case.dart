import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase(this.taskRepository);

  Future<List<Task>?>? getTasks() async => await taskRepository.getTasks();
}
