import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/countries/domain/entities/country.dart';
import 'package:todo_app/features/countries/domain/repositories/country_repository.dart';
import 'package:todo_app/features/countries/data/datasources/country_remote_datasource.dart';

/// Implementación del repositorio de países
class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;

  CountryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    try {
      final countries = await remoteDataSource.getCountries();
      return Right(countries.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
