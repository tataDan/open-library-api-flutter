// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseImpl _$$ResponseImplFromJson(Map<String, dynamic> json) =>
    _$ResponseImpl(
      numFound: (json['numFound'] as num).toInt(),
      docs: (json['docs'] as List<dynamic>)
          .map((e) => Doc.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ResponseImplToJson(_$ResponseImpl instance) =>
    <String, dynamic>{
      'numFound': instance.numFound,
      'docs': instance.docs,
    };

_$DocImpl _$$DocImplFromJson(Map<String, dynamic> json) => _$DocImpl(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      authorName: (json['author_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publisher: (json['publisher'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      person:
          (json['person'] as List<dynamic>?)?.map((e) => e as String).toList(),
      place:
          (json['place'] as List<dynamic>?)?.map((e) => e as String).toList(),
      subject:
          (json['subject'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isbn: (json['isbn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      key: json['key'] as String,
    );

Map<String, dynamic> _$$DocImplToJson(_$DocImpl instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'author_name': instance.authorName,
      'publisher': instance.publisher,
      'person': instance.person,
      'place': instance.place,
      'subject': instance.subject,
      'isbn': instance.isbn,
      'language': instance.language,
      'key': instance.key,
    };
