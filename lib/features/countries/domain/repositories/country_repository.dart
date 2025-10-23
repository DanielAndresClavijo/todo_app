import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/countries/domain/entities/country.dart';

/// Repositorio de países
abstract class CountryRepository {
  /// Obtiene todos los países desde GraphQL
  Future<Either<Failure, List<Country>>> getCountries();
}
