import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';

/// Entidad de país
@freezed
class Country with _$Country {
  const factory Country({
    required String code,
    required String name,
    required String emoji,
    required String continent,
    required String capital,
    required List<String> languages,
  }) = _Country;
}
