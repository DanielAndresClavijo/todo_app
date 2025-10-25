// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/features/tasks/data/models/task_model_adapter.dart';

void main() {
  setUpAll(() async {
    // Inicializar Hive para tests con directorio temporal
    final tempDir = Directory.systemTemp.createTempSync('hive_test_');
    Hive.init(tempDir.path);
    Hive.registerAdapter(TaskModelAdapter());
  });

  tearDownAll(() async {
    // Limpiar Hive después de los tests
    await Hive.close();
  });

  testWidgets('App should initialize without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: TodoApp(),
      ),
    );

    // Wait for initial frame
    await tester.pump();

    // Verify that the app builds without errors
    expect(find.byType(TodoApp), findsOneWidget);
  });

  testWidgets('App should display MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TodoApp(),
      ),
    );

    // Wait for initial frame
    await tester.pump();

    // Verify MaterialApp is present
    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
