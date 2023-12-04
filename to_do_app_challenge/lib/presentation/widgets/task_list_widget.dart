import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_challenge/dependency_injection/di_container.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, List<Task>>(
      builder: (context, state) {
        if (state.isEmpty) return const Text('There are no tasks to do.');

        return ListView.builder(
          itemCount: state.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final task = state[index];
            return TaskItemWidget(task: task);
          },
        );
      },
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.description),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          sl<TaskCubit>().toggleTask(task);
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: const Icon(Icons.edit_road),
              onPressed: () async {
                final _controller =
                    TextEditingController(text: task.description);
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Edit Task'),
                      content: TextField(
                        controller: _controller,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            task.description = _controller.text;
                            sl<TaskCubit>().updateTask(task);
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              }),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              sl<TaskCubit>().deleteTask(task);
            },
          ),
        ],
      ),
    );
  }
}
