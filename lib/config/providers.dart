import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:todo_app/core/database/hive_helper.dart';
import 'package:todo_app/features/countries/data/datasources/country_remote_datasource.dart';
import 'package:todo_app/features/countries/data/repositories/country_repository_impl.dart';
import 'package:todo_app/features/countries/domain/repositories/country_repository.dart';
import 'package:todo_app/features/countries/domain/usecases/get_countries.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:todo_app/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/create_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_tasks.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_tasks_by_status.dart';
import 'package:todo_app/features/tasks/domain/usecases/update_task.dart';

// ============ Core Providers ============

/// Provider del DatabaseHelper (Hive)
final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

/// Provider de Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

/// Provider de GraphQL Client
final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
});

// ============ Task Providers ============

/// Provider del TaskLocalDataSource
final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return TaskLocalDataSourceImpl(databaseHelper: databaseHelper);
});

/// Provider del TaskRemoteDataSource
final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return TaskRemoteDataSourceImpl(dio: dio);
});

/// Provider del TaskRepository
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remoteDataSource = ref.watch(taskRemoteDataSourceProvider);
  final localDataSource = ref.watch(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// Provider de GetTasks UseCase
final getTasksUseCaseProvider = Provider<GetTasks>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetTasks(repository);
});

/// Provider de GetTasksByStatus UseCase
final getTasksByStatusUseCaseProvider = Provider<GetTasksByStatus>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetTasksByStatus(repository);
});

/// Provider de CreateTask UseCase
final createTaskUseCaseProvider = Provider<CreateTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return CreateTask(repository);
});

/// Provider de UpdateTask UseCase
final updateTaskUseCaseProvider = Provider<UpdateTask>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTask(repository);
});

// ============ Country Providers ============

/// Provider del CountryRemoteDataSource
final countryRemoteDataSourceProvider = Provider<CountryRemoteDataSource>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return CountryRemoteDataSourceImpl(client: client);
});

/// Provider del CountryRepository
final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  final remoteDataSource = ref.watch(countryRemoteDataSourceProvider);
  return CountryRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// Provider de GetCountries UseCase
final getCountriesUseCaseProvider = Provider<GetCountries>((ref) {
  final repository = ref.watch(countryRepositoryProvider);
  return GetCountries(repository);
});
