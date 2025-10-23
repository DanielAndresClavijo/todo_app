import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/error/failures.dart';

/// Interfaz base para casos de uso
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Clase base para todos los casos de uso sin parámetros
class NoParams {
  const NoParams();
}
