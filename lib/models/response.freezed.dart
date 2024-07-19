// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return _Response.fromJson(json);
}

/// @nodoc
mixin _$Response {
  int get numFound => throw _privateConstructorUsedError;
  List<Doc> get docs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseCopyWith<Response> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCopyWith<$Res> {
  factory $ResponseCopyWith(Response value, $Res Function(Response) then) =
      _$ResponseCopyWithImpl<$Res, Response>;
  @useResult
  $Res call({int numFound, List<Doc> docs});
}

/// @nodoc
class _$ResponseCopyWithImpl<$Res, $Val extends Response>
    implements $ResponseCopyWith<$Res> {
  _$ResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numFound = null,
    Object? docs = null,
  }) {
    return _then(_value.copyWith(
      numFound: null == numFound
          ? _value.numFound
          : numFound // ignore: cast_nullable_to_non_nullable
              as int,
      docs: null == docs
          ? _value.docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<Doc>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseImplCopyWith<$Res>
    implements $ResponseCopyWith<$Res> {
  factory _$$ResponseImplCopyWith(
          _$ResponseImpl value, $Res Function(_$ResponseImpl) then) =
      __$$ResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int numFound, List<Doc> docs});
}

/// @nodoc
class __$$ResponseImplCopyWithImpl<$Res>
    extends _$ResponseCopyWithImpl<$Res, _$ResponseImpl>
    implements _$$ResponseImplCopyWith<$Res> {
  __$$ResponseImplCopyWithImpl(
      _$ResponseImpl _value, $Res Function(_$ResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numFound = null,
    Object? docs = null,
  }) {
    return _then(_$ResponseImpl(
      numFound: null == numFound
          ? _value.numFound
          : numFound // ignore: cast_nullable_to_non_nullable
              as int,
      docs: null == docs
          ? _value._docs
          : docs // ignore: cast_nullable_to_non_nullable
              as List<Doc>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseImpl implements _Response {
  _$ResponseImpl({required this.numFound, required final List<Doc> docs})
      : _docs = docs;

  factory _$ResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponseImplFromJson(json);

  @override
  final int numFound;
  final List<Doc> _docs;
  @override
  List<Doc> get docs {
    if (_docs is EqualUnmodifiableListView) return _docs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docs);
  }

  @override
  String toString() {
    return 'Response(numFound: $numFound, docs: $docs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseImpl &&
            (identical(other.numFound, numFound) ||
                other.numFound == numFound) &&
            const DeepCollectionEquality().equals(other._docs, _docs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, numFound, const DeepCollectionEquality().hash(_docs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      __$$ResponseImplCopyWithImpl<_$ResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseImplToJson(
      this,
    );
  }
}

abstract class _Response implements Response {
  factory _Response(
      {required final int numFound,
      required final List<Doc> docs}) = _$ResponseImpl;

  factory _Response.fromJson(Map<String, dynamic> json) =
      _$ResponseImpl.fromJson;

  @override
  int get numFound;
  @override
  List<Doc> get docs;
  @override
  @JsonKey(ignore: true)
  _$$ResponseImplCopyWith<_$ResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Doc _$DocFromJson(Map<String, dynamic> json) {
  return _Doc.fromJson(json);
}

/// @nodoc
mixin _$Doc {
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  List<String>? get authorName => throw _privateConstructorUsedError;
  List<String>? get publisher => throw _privateConstructorUsedError;
  List<String>? get person => throw _privateConstructorUsedError;
  List<String>? get place => throw _privateConstructorUsedError;
  List<String>? get subject => throw _privateConstructorUsedError;
  List<String>? get isbn => throw _privateConstructorUsedError;
  List<String>? get language => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocCopyWith<Doc> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocCopyWith<$Res> {
  factory $DocCopyWith(Doc value, $Res Function(Doc) then) =
      _$DocCopyWithImpl<$Res, Doc>;
  @useResult
  $Res call(
      {String title,
      String? subtitle,
      @JsonKey(name: 'author_name') List<String>? authorName,
      List<String>? publisher,
      List<String>? person,
      List<String>? place,
      List<String>? subject,
      List<String>? isbn,
      List<String>? language,
      String key});
}

/// @nodoc
class _$DocCopyWithImpl<$Res, $Val extends Doc> implements $DocCopyWith<$Res> {
  _$DocCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = freezed,
    Object? authorName = freezed,
    Object? publisher = freezed,
    Object? person = freezed,
    Object? place = freezed,
    Object? subject = freezed,
    Object? isbn = freezed,
    Object? language = freezed,
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      publisher: freezed == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      person: freezed == person
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocImplCopyWith<$Res> implements $DocCopyWith<$Res> {
  factory _$$DocImplCopyWith(_$DocImpl value, $Res Function(_$DocImpl) then) =
      __$$DocImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? subtitle,
      @JsonKey(name: 'author_name') List<String>? authorName,
      List<String>? publisher,
      List<String>? person,
      List<String>? place,
      List<String>? subject,
      List<String>? isbn,
      List<String>? language,
      String key});
}

/// @nodoc
class __$$DocImplCopyWithImpl<$Res> extends _$DocCopyWithImpl<$Res, _$DocImpl>
    implements _$$DocImplCopyWith<$Res> {
  __$$DocImplCopyWithImpl(_$DocImpl _value, $Res Function(_$DocImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = freezed,
    Object? authorName = freezed,
    Object? publisher = freezed,
    Object? person = freezed,
    Object? place = freezed,
    Object? subject = freezed,
    Object? isbn = freezed,
    Object? language = freezed,
    Object? key = null,
  }) {
    return _then(_$DocImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      authorName: freezed == authorName
          ? _value._authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      publisher: freezed == publisher
          ? _value._publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      person: freezed == person
          ? _value._person
          : person // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      place: freezed == place
          ? _value._place
          : place // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subject: freezed == subject
          ? _value._subject
          : subject // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isbn: freezed == isbn
          ? _value._isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocImpl implements _Doc {
  _$DocImpl(
      {required this.title,
      required this.subtitle,
      @JsonKey(name: 'author_name') required final List<String>? authorName,
      required final List<String>? publisher,
      required final List<String>? person,
      required final List<String>? place,
      required final List<String>? subject,
      required final List<String>? isbn,
      required final List<String>? language,
      required this.key})
      : _authorName = authorName,
        _publisher = publisher,
        _person = person,
        _place = place,
        _subject = subject,
        _isbn = isbn,
        _language = language;

  factory _$DocImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocImplFromJson(json);

  @override
  final String title;
  @override
  final String? subtitle;
  final List<String>? _authorName;
  @override
  @JsonKey(name: 'author_name')
  List<String>? get authorName {
    final value = _authorName;
    if (value == null) return null;
    if (_authorName is EqualUnmodifiableListView) return _authorName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _publisher;
  @override
  List<String>? get publisher {
    final value = _publisher;
    if (value == null) return null;
    if (_publisher is EqualUnmodifiableListView) return _publisher;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _person;
  @override
  List<String>? get person {
    final value = _person;
    if (value == null) return null;
    if (_person is EqualUnmodifiableListView) return _person;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _place;
  @override
  List<String>? get place {
    final value = _place;
    if (value == null) return null;
    if (_place is EqualUnmodifiableListView) return _place;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _subject;
  @override
  List<String>? get subject {
    final value = _subject;
    if (value == null) return null;
    if (_subject is EqualUnmodifiableListView) return _subject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _isbn;
  @override
  List<String>? get isbn {
    final value = _isbn;
    if (value == null) return null;
    if (_isbn is EqualUnmodifiableListView) return _isbn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _language;
  @override
  List<String>? get language {
    final value = _language;
    if (value == null) return null;
    if (_language is EqualUnmodifiableListView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String key;

  @override
  String toString() {
    return 'Doc(title: $title, subtitle: $subtitle, authorName: $authorName, publisher: $publisher, person: $person, place: $place, subject: $subject, isbn: $isbn, language: $language, key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            const DeepCollectionEquality()
                .equals(other._authorName, _authorName) &&
            const DeepCollectionEquality()
                .equals(other._publisher, _publisher) &&
            const DeepCollectionEquality().equals(other._person, _person) &&
            const DeepCollectionEquality().equals(other._place, _place) &&
            const DeepCollectionEquality().equals(other._subject, _subject) &&
            const DeepCollectionEquality().equals(other._isbn, _isbn) &&
            const DeepCollectionEquality().equals(other._language, _language) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      subtitle,
      const DeepCollectionEquality().hash(_authorName),
      const DeepCollectionEquality().hash(_publisher),
      const DeepCollectionEquality().hash(_person),
      const DeepCollectionEquality().hash(_place),
      const DeepCollectionEquality().hash(_subject),
      const DeepCollectionEquality().hash(_isbn),
      const DeepCollectionEquality().hash(_language),
      key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocImplCopyWith<_$DocImpl> get copyWith =>
      __$$DocImplCopyWithImpl<_$DocImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocImplToJson(
      this,
    );
  }
}

abstract class _Doc implements Doc {
  factory _Doc(
      {required final String title,
      required final String? subtitle,
      @JsonKey(name: 'author_name') required final List<String>? authorName,
      required final List<String>? publisher,
      required final List<String>? person,
      required final List<String>? place,
      required final List<String>? subject,
      required final List<String>? isbn,
      required final List<String>? language,
      required final String key}) = _$DocImpl;

  factory _Doc.fromJson(Map<String, dynamic> json) = _$DocImpl.fromJson;

  @override
  String get title;
  @override
  String? get subtitle;
  @override
  @JsonKey(name: 'author_name')
  List<String>? get authorName;
  @override
  List<String>? get publisher;
  @override
  List<String>? get person;
  @override
  List<String>? get place;
  @override
  List<String>? get subject;
  @override
  List<String>? get isbn;
  @override
  List<String>? get language;
  @override
  String get key;
  @override
  @JsonKey(ignore: true)
  _$$DocImplCopyWith<_$DocImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
