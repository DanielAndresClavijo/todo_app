import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/features/countries/domain/entities/country.dart';

part 'country_model.freezed.dart';
part 'country_model.g.dart';

/// Modelo de datos para países con Freezed
@freezed
class CountryModel with _$CountryModel {
  const CountryModel._();

  const factory CountryModel({
    required String code,
    required String name,
    required String emoji,
    required ContinentModel continent,
    @Default('') String capital,
    @Default([]) List<LanguageModel> languages,
  }) = _CountryModel;

  /// Constructor desde JSON
  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  /// Convertir a entidad
  Country toEntity() {
    return Country(
      code: code,
      name: name,
      emoji: emoji,
      continent: continent.name,
      capital: capital,
      languages: languages.map((l) => l.name).toList(),
    );
  }
}

@freezed
class ContinentModel with _$ContinentModel {
  const factory ContinentModel({
    required String name,
  }) = _ContinentModel;

  factory ContinentModel.fromJson(Map<String, dynamic> json) =>
      _$ContinentModelFromJson(json);
}

@freezed
class LanguageModel with _$LanguageModel {
  const factory LanguageModel({
    required String name,
  }) = _LanguageModel;

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
}
