import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doc_filters_provider.g.dart';

class DocFiltersClass {
  DocFiltersClass({
    required this.titleExact,
    required this.authorExact,
    required this.publisherExact,
    required this.personExact,
    required this.placeExact,
    required this.subjectExact,
    required this.titleSubstring,
    required this.authorSubstring,
    required this.publisherSubstring,
    required this.personSubstring,
    required this.placeSubstring,
    required this.subjectSubstring,
  });

  bool titleExact = false;
  bool authorExact = false;
  bool publisherExact = false;
  bool personExact = false;
  bool placeExact = false;
  bool subjectExact = false;
  bool titleSubstring = false;
  bool authorSubstring = false;
  bool publisherSubstring = false;
  bool personSubstring = false;
  bool placeSubstring = false;
  bool subjectSubstring = false;
}

@riverpod
class DocFilters extends _$DocFilters {
  @override
  DocFiltersClass build() {
    return DocFiltersClass(
      titleExact: false,
      authorExact: false,
      publisherExact: false,
      personExact: false,
      placeExact: false,
      subjectExact: false,
      titleSubstring: false,
      authorSubstring: false,
      publisherSubstring: false,
      personSubstring: false,
      placeSubstring: false,
      subjectSubstring: false,
    );
  }
}
