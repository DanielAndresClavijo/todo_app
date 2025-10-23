import 'package:fpdart/fpdart.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_tasks.dart';

// Mock del repositorio
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTasks useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTasks(mockTaskRepository);
  });

  const tTask1 = Task(
    id: 1,
    userId: 1,
    title: 'Test Task 1',
    completed: false,
  );

  const tTask2 = Task(
    id: 2,
    userId: 1,
    title: 'Test Task 2',
    completed: true,
  );

  final tTaskList = [tTask1, tTask2];

  test('should get tasks from the repository', () async {
    // Arrange
    when(() => mockTaskRepository.getTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result, Right(tTaskList));
    verify(() => mockTaskRepository.getTasks()).called(1);
    verifyNoMoreInteractions(mockTaskRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    const tFailure = Failure.database('Database error');
    when(() => mockTaskRepository.getTasks())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockTaskRepository.getTasks()).called(1);
    verifyNoMoreInteractions(mockTaskRepository);
  });

  test('should return empty list when no tasks exist', () async {
    // Arrange
    when(() => mockTaskRepository.getTasks())
        .thenAnswer((_) async => const Right<Failure, List<Task>>([]));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result.isRight(), true);
    verify(() => mockTaskRepository.getTasks()).called(1);
  });

  test('should maintain task properties correctly', () async {
    // Arrange
    when(() => mockTaskRepository.getTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    result.fold(
      (failure) => fail('Should not return failure'),
      (tasks) {
        expect(tasks.length, 2);
        expect(tasks[0].id, 1);
        expect(tasks[0].title, 'Test Task 1');
        expect(tasks[0].completed, false);
        expect(tasks[1].id, 2);
        expect(tasks[1].title, 'Test Task 2');
        expect(tasks[1].completed, true);
      },
    );
  });
}
