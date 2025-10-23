import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/countries/domain/entities/country.dart';
import 'package:todo_app/features/countries/domain/repositories/country_repository.dart';

/// Caso de uso para obtener países
class GetCountries implements UseCase<List<Country>, NoParams> {
  final CountryRepository repository;

  GetCountries(this.repository);

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
