import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state.tasks.isEmpty) {
          return const Text('There are no tasks to do.');
        } else if (state.isLoading) {
          return const CircularProgressIndicator.adaptive();
        }

        return ListView.builder(
          itemCount: state.tasks.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return TaskItemWidget(
              task: task,
              index: index,
            );
          },
        );
      },
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final int index;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id.toString()),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          context.read<TaskCubit>().deleteTask(task, index);
        } else if (direction == DismissDirection.endToStart) {
          context.read<TaskCubit>().deleteTask(task, index);
        }
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: Text(
          task.description,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : null,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            context.read<TaskCubit>().toggleTask(task);
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _onEditTask(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  context.read<TaskCubit>().deleteTask(task, index),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEditTask(BuildContext contextApp) async {
    final controller = TextEditingController(text: task.description);

    await showDialog(
      context: contextApp,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                task.description = controller.text;
                contextApp.read<TaskCubit>().updateTask(task);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
