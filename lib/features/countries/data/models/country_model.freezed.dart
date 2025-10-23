// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return _CountryModel.fromJson(json);
}

/// @nodoc
mixin _$CountryModel {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  ContinentModel get continent => throw _privateConstructorUsedError;
  String get capital => throw _privateConstructorUsedError;
  List<LanguageModel> get languages => throw _privateConstructorUsedError;

  /// Serializes this CountryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryModelCopyWith<CountryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryModelCopyWith<$Res> {
  factory $CountryModelCopyWith(
    CountryModel value,
    $Res Function(CountryModel) then,
  ) = _$CountryModelCopyWithImpl<$Res, CountryModel>;
  @useResult
  $Res call({
    String code,
    String name,
    String emoji,
    ContinentModel continent,
    String capital,
    List<LanguageModel> languages,
  });

  $ContinentModelCopyWith<$Res> get continent;
}

/// @nodoc
class _$CountryModelCopyWithImpl<$Res, $Val extends CountryModel>
    implements $CountryModelCopyWith<$Res> {
  _$CountryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? emoji = null,
    Object? continent = null,
    Object? capital = null,
    Object? languages = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            continent: null == continent
                ? _value.continent
                : continent // ignore: cast_nullable_to_non_nullable
                      as ContinentModel,
            capital: null == capital
                ? _value.capital
                : capital // ignore: cast_nullable_to_non_nullable
                      as String,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<LanguageModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContinentModelCopyWith<$Res> get continent {
    return $ContinentModelCopyWith<$Res>(_value.continent, (value) {
      return _then(_value.copyWith(continent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CountryModelImplCopyWith<$Res>
    implements $CountryModelCopyWith<$Res> {
  factory _$$CountryModelImplCopyWith(
    _$CountryModelImpl value,
    $Res Function(_$CountryModelImpl) then,
  ) = __$$CountryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String emoji,
    ContinentModel continent,
    String capital,
    List<LanguageModel> languages,
  });

  @override
  $ContinentModelCopyWith<$Res> get continent;
}

/// @nodoc
class __$$CountryModelImplCopyWithImpl<$Res>
    extends _$CountryModelCopyWithImpl<$Res, _$CountryModelImpl>
    implements _$$CountryModelImplCopyWith<$Res> {
  __$$CountryModelImplCopyWithImpl(
    _$CountryModelImpl _value,
    $Res Function(_$CountryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? emoji = null,
    Object? continent = null,
    Object? capital = null,
    Object? languages = null,
  }) {
    return _then(
      _$CountryModelImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        continent: null == continent
            ? _value.continent
            : continent // ignore: cast_nullable_to_non_nullable
                  as ContinentModel,
        capital: null == capital
            ? _value.capital
            : capital // ignore: cast_nullable_to_non_nullable
                  as String,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<LanguageModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryModelImpl extends _CountryModel {
  const _$CountryModelImpl({
    required this.code,
    required this.name,
    required this.emoji,
    required this.continent,
    this.capital = '',
    final List<LanguageModel> languages = const [],
  }) : _languages = languages,
       super._();

  factory _$CountryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryModelImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String emoji;
  @override
  final ContinentModel continent;
  @override
  @JsonKey()
  final String capital;
  final List<LanguageModel> _languages;
  @override
  @JsonKey()
  List<LanguageModel> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  String toString() {
    return 'CountryModel(code: $code, name: $name, emoji: $emoji, continent: $continent, capital: $capital, languages: $languages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.continent, continent) ||
                other.continent == continent) &&
            (identical(other.capital, capital) || other.capital == capital) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    emoji,
    continent,
    capital,
    const DeepCollectionEquality().hash(_languages),
  );

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryModelImplCopyWith<_$CountryModelImpl> get copyWith =>
      __$$CountryModelImplCopyWithImpl<_$CountryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryModelImplToJson(this);
  }
}

abstract class _CountryModel extends CountryModel {
  const factory _CountryModel({
    required final String code,
    required final String name,
    required final String emoji,
    required final ContinentModel continent,
    final String capital,
    final List<LanguageModel> languages,
  }) = _$CountryModelImpl;
  const _CountryModel._() : super._();

  factory _CountryModel.fromJson(Map<String, dynamic> json) =
      _$CountryModelImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String get emoji;
  @override
  ContinentModel get continent;
  @override
  String get capital;
  @override
  List<LanguageModel> get languages;

  /// Create a copy of CountryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryModelImplCopyWith<_$CountryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContinentModel _$ContinentModelFromJson(Map<String, dynamic> json) {
  return _ContinentModel.fromJson(json);
}

/// @nodoc
mixin _$ContinentModel {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this ContinentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContinentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContinentModelCopyWith<ContinentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContinentModelCopyWith<$Res> {
  factory $ContinentModelCopyWith(
    ContinentModel value,
    $Res Function(ContinentModel) then,
  ) = _$ContinentModelCopyWithImpl<$Res, ContinentModel>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$ContinentModelCopyWithImpl<$Res, $Val extends ContinentModel>
    implements $ContinentModelCopyWith<$Res> {
  _$ContinentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContinentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContinentModelImplCopyWith<$Res>
    implements $ContinentModelCopyWith<$Res> {
  factory _$$ContinentModelImplCopyWith(
    _$ContinentModelImpl value,
    $Res Function(_$ContinentModelImpl) then,
  ) = __$$ContinentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$ContinentModelImplCopyWithImpl<$Res>
    extends _$ContinentModelCopyWithImpl<$Res, _$ContinentModelImpl>
    implements _$$ContinentModelImplCopyWith<$Res> {
  __$$ContinentModelImplCopyWithImpl(
    _$ContinentModelImpl _value,
    $Res Function(_$ContinentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContinentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$ContinentModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentModelImpl implements _ContinentModel {
  const _$ContinentModelImpl({required this.name});

  factory _$ContinentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContinentModelImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'ContinentModel(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentModelImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of ContinentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContinentModelImplCopyWith<_$ContinentModelImpl> get copyWith =>
      __$$ContinentModelImplCopyWithImpl<_$ContinentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentModelImplToJson(this);
  }
}

abstract class _ContinentModel implements ContinentModel {
  const factory _ContinentModel({required final String name}) =
      _$ContinentModelImpl;

  factory _ContinentModel.fromJson(Map<String, dynamic> json) =
      _$ContinentModelImpl.fromJson;

  @override
  String get name;

  /// Create a copy of ContinentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContinentModelImplCopyWith<_$ContinentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) {
  return _LanguageModel.fromJson(json);
}

/// @nodoc
mixin _$LanguageModel {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this LanguageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageModelCopyWith<LanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageModelCopyWith<$Res> {
  factory $LanguageModelCopyWith(
    LanguageModel value,
    $Res Function(LanguageModel) then,
  ) = _$LanguageModelCopyWithImpl<$Res, LanguageModel>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$LanguageModelCopyWithImpl<$Res, $Val extends LanguageModel>
    implements $LanguageModelCopyWith<$Res> {
  _$LanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LanguageModelImplCopyWith<$Res>
    implements $LanguageModelCopyWith<$Res> {
  factory _$$LanguageModelImplCopyWith(
    _$LanguageModelImpl value,
    $Res Function(_$LanguageModelImpl) then,
  ) = __$$LanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$LanguageModelImplCopyWithImpl<$Res>
    extends _$LanguageModelCopyWithImpl<$Res, _$LanguageModelImpl>
    implements _$$LanguageModelImplCopyWith<$Res> {
  __$$LanguageModelImplCopyWithImpl(
    _$LanguageModelImpl _value,
    $Res Function(_$LanguageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$LanguageModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageModelImpl implements _LanguageModel {
  const _$LanguageModelImpl({required this.name});

  factory _$LanguageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageModelImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'LanguageModel(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageModelImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      __$$LanguageModelImplCopyWithImpl<_$LanguageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageModelImplToJson(this);
  }
}

abstract class _LanguageModel implements LanguageModel {
  const factory _LanguageModel({required final String name}) =
      _$LanguageModelImpl;

  factory _LanguageModel.fromJson(Map<String, dynamic> json) =
      _$LanguageModelImpl.fromJson;

  @override
  String get name;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
