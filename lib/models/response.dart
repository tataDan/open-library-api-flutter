import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@freezed
class Response with _$Response {
  factory Response({
    required int numFound,
    required List<Doc> docs,
  }) = _Response;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}

@freezed
class Doc with _$Doc {
  factory Doc({
    required String title,
    required String? subtitle,
    @JsonKey(name: 'author_name') required List<String>? authorName,
    required List<String>? publisher,
    required List<String>? person,
    required List<String>? place,
    required List<String>? subject,
    required List<String>? isbn,
    required List<String>? language,
    required String key,
  }) = _Doc;

  factory Doc.fromJson(Map<String, dynamic> json) => _$DocFromJson(json);
}
