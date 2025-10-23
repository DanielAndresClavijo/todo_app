import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/countries/domain/entities/country.dart';
import 'package:todo_app/features/countries/domain/usecases/get_countries.dart';
import 'package:todo_app/config/providers.dart';

/// Estados posibles para los países
enum CountryStatus { initial, loading, loaded, error }

/// Estado de los países
class CountryState {
  final CountryStatus status;
  final List<Country> countries;
  final String? errorMessage;

  CountryState({
    required this.status,
    required this.countries,
    this.errorMessage,
  });

  CountryState copyWith({
    CountryStatus? status,
    List<Country>? countries,
    String? errorMessage,
  }) {
    return CountryState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Notifier para gestionar el estado de los países
class CountryNotifier extends StateNotifier<CountryState> {
  final GetCountries _getCountries;

  CountryNotifier({
    required GetCountries getCountries,
  })  : _getCountries = getCountries,
        super(CountryState(status: CountryStatus.initial, countries: []));

  /// Carga todos los países
  Future<void> loadCountries() async {
    state = state.copyWith(status: CountryStatus.loading);

    final result = await _getCountries(const NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        status: CountryStatus.error,
        errorMessage: failure.message,
      ),
      (countries) => state = state.copyWith(
        status: CountryStatus.loaded,
        countries: countries,
      ),
    );
  }
}

/// Provider del CountryNotifier
final countryNotifierProvider = StateNotifierProvider<CountryNotifier, CountryState>((ref) {
  final getCountries = ref.watch(getCountriesUseCaseProvider);

  return CountryNotifier(getCountries: getCountries);
});
