import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_app/features/countries/data/models/country_model.dart';

/// Interfaz para el datasource remoto de países
abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}

/// Implementación del datasource usando GraphQL
class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final GraphQLClient client;

  CountryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CountryModel>> getCountries() async {
    const String query = r'''
      query GetCountries {
        countries {
          code
          name
          emoji
          capital
          continent {
            name
          }
          languages {
            name
          }
        }
      }
    ''';

    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
      );

      final result = await client.query(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final List<dynamic> countries = result.data?['countries'] ?? [];
      return countries.map((json) => CountryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }
}
