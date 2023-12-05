import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';

class AddTaskWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter a new task'),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              onFieldSubmitted: (value) => _addTask(context),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addTask(context),
          ),
        ],
      ),
    );
  }

  void _addTask(BuildContext context) {
    final task = Task(description: _controller.text);
    _controller.clear();
    context.read<TaskCubit>().addTask(task);
  }
}
