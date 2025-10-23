import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Clase base para todos los fallos en la aplicación
@freezed
class Failure with _$Failure {
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.database(String message) = DatabaseFailure;
}
