// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryModelImpl _$$CountryModelImplFromJson(Map<String, dynamic> json) =>
    _$CountryModelImpl(
      code: json['code'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      continent: ContinentModel.fromJson(
        json['continent'] as Map<String, dynamic>,
      ),
      capital: json['capital'] as String? ?? '',
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CountryModelImplToJson(_$CountryModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'emoji': instance.emoji,
      'continent': instance.continent,
      'capital': instance.capital,
      'languages': instance.languages,
    };

_$ContinentModelImpl _$$ContinentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContinentModelImpl(name: json['name'] as String);

Map<String, dynamic> _$$ContinentModelImplToJson(
  _$ContinentModelImpl instance,
) => <String, dynamic>{'name': instance.name};

_$LanguageModelImpl _$$LanguageModelImplFromJson(Map<String, dynamic> json) =>
    _$LanguageModelImpl(name: json['name'] as String);

Map<String, dynamic> _$$LanguageModelImplToJson(_$LanguageModelImpl instance) =>
    <String, dynamic>{'name': instance.name};
