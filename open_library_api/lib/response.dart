import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_library_api/document.dart';

class Response {
  final int numFound;
  List<Doc> docs;

  Response({
    required this.numFound,
    required this.docs,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final docsData = json['docs'] as List<dynamic>?;
    return Response(
      numFound: json['numFound'],
      docs: docsData != null
          ? docsData
              .map((docsData) => Doc.fromJson(docsData as Map<String, dynamic>))
              .toList()
          : <Doc>[],
    );
  }
}

Future<Response> getResponse(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load response');
  }
}
