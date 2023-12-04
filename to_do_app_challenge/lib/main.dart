import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app_challenge/dependency_injection/di_container.dart';
import 'package:to_do_app_challenge/presentation/pages/home_page.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';
import 'dependency_injection/di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.init();
  // Listen for the Isar database becoming ready.
  await GetIt.instance.allReady();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TaskCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To do list App',
      home: HomePage(),
    );
  }
}
