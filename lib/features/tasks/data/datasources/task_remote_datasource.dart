import 'package:dio/dio.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

/// Interfaz para el datasource remoto de tareas
abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
}

/// Implementación del datasource remoto usando Dio
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/todos');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
}
