import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'page_provider.dart';
import '../models/response.dart';
import 'search_values_provider.dart';

part 'response_provider.g.dart';

@riverpod
Future<Response> response(ResponseRef ref) async {
  int page = ref.watch(pageProvider);
  Map<String, String> searchValues = ref.watch(searchValuesProvider);

  final response = await http.get(Uri.https('openlibrary.org', '/search.json',
      {...searchValues, 'page': page.toString()}));

  if (response.statusCode != 200) {
    return Response(numFound: 0, docs: []);
  }

  final json = jsonDecode(response.body) as Map<String, dynamic>;

  return Response.fromJson(json);
}
