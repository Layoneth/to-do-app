import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_challenge/dependency_injection/di_container.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';
import 'package:to_do_app_challenge/presentation/widgets/add_task_widget.dart';
import 'package:to_do_app_challenge/presentation/widgets/task_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Todo List'),
      ),
      body: BlocProvider(
        create: (context) => sl<TaskCubit>()..getTasks(),
        child: Column(
          children: [
            const Expanded(child: TaskListWidget()),
            AddTaskWidget(),
          ],
        ),
      ),
    );
  }
}
