import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/response.dart';
import 'doc_filters_provider.dart';
import 'response_provider.dart';
import 'search_values_provider.dart';

part 'filtered_docs_provider.g.dart';

@riverpod
class FilterDocs extends _$FilterDocs {
  @override
  List<Doc> build() {
    List<Doc> newDocs = [];
    final AsyncValue<Response> response = ref.watch(responseProvider);
    List<Doc> docs = response.value!.docs;

    for (Doc doc in docs) {
      if (!filtered(doc)) {
        newDocs.add(doc);
      }
    }

    return newDocs;
  }

  bool setExactFilter(
      List<String>? itemArray, String fieldText, bool searchType) {
    bool itemFiltered = false;
    if (itemArray != null) {
      if (searchType) {
        int unFilterCount = 0;
        for (String item in itemArray) {
          if (fieldText.toUpperCase().trim() == item.toUpperCase().trim()) {
            unFilterCount++;
          }
        }
        if (unFilterCount > 0) {
          itemFiltered = false;
        } else {
          itemFiltered = true;
        }
      }
    }
    return itemFiltered;
  }

  bool setSubstringFilter(
      List<String>? itemArray, String fieldText, bool searchType) {
    bool itemFiltered = false;
    if (itemArray != null) {
      if (searchType) {
        int unFilterCount = 0;
        for (String item in itemArray) {
          if (item
              .toUpperCase()
              .trim()
              .contains(fieldText.toUpperCase().trim())) {
            unFilterCount++;
          }
        }
        if (unFilterCount > 0) {
          itemFiltered = false;
        } else {
          itemFiltered = true;
        }
      }
    }
    return itemFiltered;
  }

  bool filtered(Doc doc) {
    bool authorExactFiltered = false;
    bool authorSubstringFiltered = false;
    bool publisherExactFiltered = false;
    bool publisherSubstringFiltered = false;
    bool personExactFiltered = false;
    bool personSubstringFiltered = false;
    bool placeExactFiltered = false;
    bool placeSubstringFiltered = false;
    bool subjectExactFiltered = false;
    bool subjectSubstringFiltered = false;

    Map<String, String> searchValues = ref.watch(searchValuesProvider);

    DocFiltersClass docFilters = ref.watch(docFiltersProvider);

    bool titleExactFiltered = (docFilters.titleExact) &&
        (searchValues['title']?.toUpperCase().trim() !=
            doc.title.toUpperCase().trim());

    bool titleSubstringFiltered = docFilters.titleSubstring &&
        !doc.title
            .toUpperCase()
            .trim()
            .contains(searchValues['title']!.toUpperCase().trim());

    if (searchValues['author'] != null) {
      authorExactFiltered = setExactFilter(
        doc.authorName,
        searchValues['author']!,
        docFilters.authorExact,
      );

      authorSubstringFiltered = setSubstringFilter(
        doc.authorName,
        searchValues['author']!,
        docFilters.authorSubstring,
      );
    }

    if (searchValues['publisher'] != null) {
      publisherExactFiltered = setExactFilter(
        doc.publisher,
        searchValues['publisher']!,
        docFilters.publisherExact,
      );

      publisherSubstringFiltered = setSubstringFilter(
        doc.publisher,
        searchValues['publisher']!,
        docFilters.publisherSubstring,
      );
    }

    if (searchValues['person'] != null) {
      personExactFiltered = setExactFilter(
        doc.person,
        searchValues['person']!,
        docFilters.personExact,
      );

      personSubstringFiltered = setSubstringFilter(
        doc.person,
        searchValues['person']!,
        docFilters.personSubstring,
      );
    }

    if (searchValues['place'] != null) {
      placeExactFiltered = setExactFilter(
        doc.place,
        searchValues['place']!,
        docFilters.placeExact,
      );

      placeSubstringFiltered = setSubstringFilter(
        doc.place,
        searchValues['place']!,
        docFilters.placeSubstring,
      );
    }

    if (searchValues['subject'] != null) {
      subjectExactFiltered = setExactFilter(
        doc.subject,
        searchValues['subject']!,
        docFilters.subjectExact,
      );

      subjectSubstringFiltered = setSubstringFilter(
        doc.subject,
        searchValues['subject']!,
        docFilters.subjectSubstring,
      );
    }

    if ((titleExactFiltered ||
        titleSubstringFiltered ||
        authorExactFiltered ||
        authorSubstringFiltered ||
        publisherExactFiltered ||
        publisherSubstringFiltered ||
        personExactFiltered ||
        personSubstringFiltered ||
        placeExactFiltered ||
        placeSubstringFiltered ||
        subjectExactFiltered ||
        subjectSubstringFiltered)) {
      return true;
    } else {
      return false;
    }
  }
}
