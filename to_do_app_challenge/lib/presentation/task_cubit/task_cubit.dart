import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:to_do_app_challenge/dependency_injection/di_container.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/use_cases/create_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/delete_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/get_tasks_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/toggle_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/update_task_use_case.dart';

part 'task_state.dart';

// Cubit for managing the state of tasks
class TaskCubit extends Cubit<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final CreateTaskUseCase createTasksUseCase;
  final UpdateTaskUseCase updateTasksUseCase;
  final DeleteTaskUseCase deleteTasksUseCase;
  final ToggleTaskUseCase toggleTaskUseCase;

  TaskCubit({
    required this.getTasksUseCase,
    required this.createTasksUseCase,
    required this.updateTasksUseCase,
    required this.deleteTasksUseCase,
    required this.toggleTaskUseCase,
  }) : super(const TaskState());

  Future<void> getTasks() async {
    emit(state.copyWith(isLoading: true));
    final tasks = await getTasksUseCase.getTasks();
    emit(state.copyWith(
      tasks: tasks,
      isLoading: false,
    ));
  }

  Future<void> addTask(Task task) async {
    await createTasksUseCase.createTask(description: task.description);
    await getTasks();
  }

  Future<void> updateTask(Task task) async {
    await updateTasksUseCase.updateTask(task: task);
    await getTasks();
  }

  Future<void> toggleTask(Task task) async {
    await toggleTaskUseCase.toggleTask(task: task);
    await getTasks();
  }

  Future<void> deleteTask(Task task, int index) async {
    await deleteTasksUseCase.deleteTask(task: task);
    await getTasks();
  }

  @override
  Future<void> close() {
    sl<Isar>().close();
    return super.close();
  }
}
