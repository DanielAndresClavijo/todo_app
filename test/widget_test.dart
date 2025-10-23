// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:flutter/material.dart';
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

  testWidgets('App should display bottom navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: TodoApp(),
      ),
    );

    // Wait for async operations
    await tester.pumpAndSettle();

    // Verify that the bottom navigation bar is displayed
    expect(find.text('Tareas'), findsOneWidget);
    expect(find.text('Países'), findsOneWidget);
  });

  testWidgets('Task screen should have FAB button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TodoApp(),
      ),
    );

    // Wait for initial load
    await tester.pumpAndSettle();

    // Verify that FAB is displayed
    expect(find.byType(FloatingActionButton), findsOneWidget);
    
    // Verify initial screen title
    expect(find.text('Mis Tareas'), findsOneWidget);
  });
}
