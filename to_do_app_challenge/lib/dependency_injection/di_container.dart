import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app_challenge/data/datasource/basic_datasource.dart';
import 'package:to_do_app_challenge/data/datasource/local_datasource.dart';
import 'package:to_do_app_challenge/data/repositories/task_repository_impl.dart';
import 'package:to_do_app_challenge/domain/models/task_model.dart';
import 'package:to_do_app_challenge/domain/repositories/task_repository.dart';
import 'package:to_do_app_challenge/domain/use_cases/create_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/delete_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/get_tasks_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/toggle_task_use_case.dart';
import 'package:to_do_app_challenge/domain/use_cases/update_task_use_case.dart';
import 'package:to_do_app_challenge/presentation/task_cubit/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Local db
  try {
    sl.registerSingletonAsync<Isar>(
      () async {
        final dir = await getApplicationDocumentsDirectory();
        log('dir.path => ${dir.path}');
        return Isar.getInstance('default') ??
            await Isar.open(
              [TaskSchema],
              directory: dir.path,
            );
      },
    );
  } catch (e) {
    //print(e);
  }

  // Bloc
  sl.registerLazySingleton(
    () => TaskCubit(
      getTasksUseCase: sl(),
      createTasksUseCase: sl(),
      updateTasksUseCase: sl(),
      deleteTasksUseCase: sl(),
      toggleTaskUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => ToggleTaskUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // Data source
  sl.registerLazySingleton<BasicDataSource>(() => LocalDataSource(sl()));
}
