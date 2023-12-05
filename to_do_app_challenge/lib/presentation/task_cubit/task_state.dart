part of 'task_cubit.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final String error;
  final List<Task> tasks;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.error = '',
  });

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    String? error,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        tasks,
        isLoading,
        error,
      ];
}
