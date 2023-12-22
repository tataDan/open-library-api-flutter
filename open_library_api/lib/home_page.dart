import 'package:flutter/material.dart';
import 'package:open_library_api/document.dart';
import 'package:open_library_api/response.dart';
import 'package:open_library_api/optionClasses/search_type_options.dart';
import 'package:open_library_api/show_documents_widget.dart';
import 'package:open_library_api/optionClasses/show_options.dart';
import 'package:open_library_api/url_launchers.dart';

enum QueryFields {
  title,
  author,
  publisher,
  person,
  place,
  subject,
  isbn,
  language,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Response>? _futureResponse;
  Future<Response>? _initialResponse;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final String _urlBase = 'https://openlibrary.org/search.json';
  int _page = 0;
  bool _queryRan = false;
  int _numDocsFound = 0;
  int _pageLimit = 0;

  late ({
    String title,
    String author,
    String publisher,
    String person,
    String place,
    String subject,
    String isbn,
    String language,
  }) _textControllers;

  var showOptions = ShowOptions(
    showAuthor: true,
    showPublisher: true,
    showPerson: true,
    showPlace: true,
    showSubject: true,
    showIsbn: true,
    showLanguage: true,
  );

  var searchTypeOptions = SearchTypeOptions(
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

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _personController.dispose();
    _placeController.dispose();
    _subjectController.dispose();
    _isbnController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),
          firstSearchEntriesRow(),
          secondSearchEntriesRow(),
          showOptionsRow(),
          firstSearchFiltersRow(),
          secondSearchFiltersRow(),
          buttonRow(),
          const Divider(),
          if (_queryRan)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Page Number $_page',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 40),
                const Text(
                  'Note: To go to page 1, you can click on the "Get book documents" button.)',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          if (_futureResponse != null)
            ShowDocumentsWidget(
              futureResponse: _futureResponse,
              showOptions: showOptions,
            ),
        ],
      ),
    );
  }

  String configQuery(
      String query, String value, String itemName, int numItems) {
    String connector = '';

    if (value.isNotEmpty) {
      if (numItems == 0) {
        connector = '?';
        numItems++;
      } else {
        connector = '&';
      }
      query = '$query$connector$itemName=$value';
    }
    return query;
  }

  void clearSearchEntries() {
    _titleController.text = '';
    _authorController.text = '';
    _publisherController.text = '';
    _personController.text = '';
    _placeController.text = '';
    _subjectController.text = '';
    _isbnController.text = '';
    _languageController.text = '';
  }

  Future<void> _showEmptyFieldsDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Empty Fields'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter text into at least one search field.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool setExactFilter(
      List<dynamic>? itemArray, String fieldText, bool searchType) {
    bool itemFiltered = false;
    if (itemArray != null) {
      if (searchType) {
        for (String item in itemArray) {
          itemFiltered =
              fieldText.toUpperCase().trim() != item.toUpperCase().trim();
        }
      }
    }
    return itemFiltered;
  }

  bool setSubstringFilter(
      List<dynamic>? itemArray, String fieldText, bool searchType) {
    bool itemFiltered = false;
    if (itemArray != null) {
      if (searchType) {
        for (String item in itemArray) {
          itemFiltered = !(item
              .toUpperCase()
              .trim()
              .contains(fieldText.toUpperCase().trim()));
        }
      }
    }
    return itemFiltered;
  }

  bool filtered(Doc doc) {
    bool titleExactFiltered = (searchTypeOptions.titleExact) &&
        (_textControllers.title.toUpperCase().trim() !=
            doc.title.toUpperCase().trim());

    bool titleSubstringFiltered = searchTypeOptions.titleSubstring &&
        !doc.title
            .toUpperCase()
            .trim()
            .contains(_textControllers.title.toUpperCase().trim());

    bool authorExactFiltered = setExactFilter(
        doc.authorName, _textControllers.author, searchTypeOptions.authorExact);

    bool authorSubstringFiltered = setSubstringFilter(doc.authorName,
        _textControllers.author, searchTypeOptions.authorSubstring);

    bool publisherExactFiltered = setExactFilter(doc.publisher,
        _textControllers.publisher, searchTypeOptions.publisherExact);

    bool publisherSubstringFiltered = setSubstringFilter(doc.publisher,
        _textControllers.publisher, searchTypeOptions.publisherSubstring);

    bool personExactFiltered = setExactFilter(
        doc.person, _textControllers.person, searchTypeOptions.personExact);

    bool personSubstringFiltered = setSubstringFilter(
        doc.person, _textControllers.person, searchTypeOptions.personSubstring);

    bool placeExactFiltered = setExactFilter(
        doc.place, _textControllers.place, searchTypeOptions.placeExact);

    bool placeSubstringFiltered = setSubstringFilter(
        doc.place, _textControllers.place, searchTypeOptions.placeSubstring);

    bool subjectExactFiltered = setExactFilter(
        doc.subject, _textControllers.subject, searchTypeOptions.subjectExact);

    bool subjectSubstringFiltered = setSubstringFilter(doc.subject,
        _textControllers.subject, searchTypeOptions.subjectSubstring);

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

  int calculatePageLimit(int numDocsFound) {
    int pageLimit = 0;
    pageLimit = numDocsFound ~/ 100;
    if (numDocsFound % 100 != 0) {
      pageLimit++;
    }
    return pageLimit;
  }

  void getDocs({required isNewQuery}) {
    String query = '';
    int numItems = 0;
    int lastQueryLength = 0;
    _queryRan = true;

    if (_titleController.text.trim().isEmpty &&
        _authorController.text.trim().isEmpty &&
        _publisherController.text.trim().isEmpty &&
        _personController.text.trim().isEmpty &&
        _placeController.text.trim().isEmpty &&
        _subjectController.text.trim().isEmpty &&
        _isbnController.text.trim().isEmpty &&
        _languageController.text.trim().isEmpty) {
      _showEmptyFieldsDialog();
      return;
    }

    if (isNewQuery) {
      _page = 1;
    }

    _textControllers = (
      title: _titleController.text,
      author: _authorController.text,
      publisher: _publisherController.text,
      person: _personController.text,
      place: _placeController.text,
      subject: _subjectController.text,
      isbn: _isbnController.text,
      language: _languageController.text,
    );

    query = configQuery(
        query, _titleController.text.trim(), QueryFields.title.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(query, _authorController.text.trim(),
        QueryFields.author.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(query, _publisherController.text.trim(),
        QueryFields.publisher.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(query, _personController.text.trim(),
        QueryFields.person.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(
        query, _placeController.text.trim(), QueryFields.place.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(query, _subjectController.text.trim(),
        QueryFields.subject.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(
        query, _isbnController.text.trim(), QueryFields.isbn.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = configQuery(query, _languageController.text.trim(),
        QueryFields.language.name, numItems);
    if (query.length > lastQueryLength) {
      numItems++;
    }
    query = '$_urlBase$query&page=$_page';
    _initialResponse = getResponse(query);
    _initialResponse!.then((value) {
      List<Doc> newDocs = [];
      Future.forEach(
        value.docs,
        (doc) {
          if (!filtered(doc)) {
            newDocs.add(doc);
          }
        },
      );
      _numDocsFound = value.numFound;
      _pageLimit = calculatePageLimit(_numDocsFound);
      value.docs = newDocs;
    });

    setState(() {
      _futureResponse = _initialResponse;
    });
  }

  Padding firstSearchEntriesRow() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          const Text('Title: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter the title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Author: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                hintText: 'Enter author',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Publisher: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _publisherController,
              decoration: const InputDecoration(
                hintText: 'Enter publisher',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Person: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _personController,
              decoration: const InputDecoration(
                hintText: 'Enter person',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding secondSearchEntriesRow() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          const Text('Place: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                hintText: 'Enter place',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Subject: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                hintText: 'Enter subject',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('ISBN: '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _isbnController,
              decoration: const InputDecoration(
                hintText: 'Enter ISBN',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Language (3-letter code): '),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _languageController,
              decoration: const InputDecoration(
                hintText: 'Enter language',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding showOptionsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text(
            'Show Options:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 10),
          const Text('Author'),
          Checkbox(
            value: showOptions.showAuthor,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showAuthor = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('Publisher'),
          Checkbox(
            value: showOptions.showPublisher,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPublisher = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('Person'),
          Checkbox(
            value: showOptions.showPerson,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPerson = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('Place'),
          Checkbox(
            value: showOptions.showPlace,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPlace = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('Subject'),
          Checkbox(
            value: showOptions.showSubject,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showSubject = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('ISBN'),
          Checkbox(
            value: showOptions.showIsbn,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showIsbn = value!;
              });
            },
          ),
          const SizedBox(width: 20),
          const Text('Language'),
          Checkbox(
            value: showOptions.showLanguage,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showLanguage = value!;
              });
            },
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showOptions.showAll();
                  });
                },
                child: const Text('Show All')),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showOptions.hideAll();
                  });
                },
                child: const Text('Hide All')),
          ),
        ],
      ),
    );
  }

  Padding firstSearchFiltersRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text(
            'Filters:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Title Exact'),
                Checkbox(
                  value: searchTypeOptions.titleExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.titleExact = value!;
                      searchTypeOptions.titleSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                const Text('Title Substring'),
                Checkbox(
                  value: searchTypeOptions.titleSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.titleSubstring = value!;
                      searchTypeOptions.titleExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Author Exact'),
                Checkbox(
                  value: searchTypeOptions.authorExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.authorExact = value!;
                      searchTypeOptions.authorSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                const Text('Author Substring'),
                Checkbox(
                  value: searchTypeOptions.authorSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.authorSubstring = value!;
                      searchTypeOptions.authorExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Publisher Exact'),
                Checkbox(
                  value: searchTypeOptions.publisherExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.publisherExact = value!;
                      searchTypeOptions.publisherSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                const Text('Publisher Substring'),
                Checkbox(
                  value: searchTypeOptions.publisherSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.publisherSubstring = value!;
                      searchTypeOptions.publisherExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Padding secondSearchFiltersRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 60),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Person Exact'),
                Checkbox(
                  value: searchTypeOptions.personExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.personExact = value!;
                      searchTypeOptions.personSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 15),
                const Text('Person Substring'),
                Checkbox(
                  value: searchTypeOptions.personSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.personSubstring = value!;
                      searchTypeOptions.personExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Place Exact'),
                Checkbox(
                  value: searchTypeOptions.placeExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.placeExact = value!;
                      searchTypeOptions.placeSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                const Text('Place Substring'),
                Checkbox(
                  value: searchTypeOptions.placeSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.placeSubstring = value!;
                      searchTypeOptions.placeExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                const Text('Subject Exact'),
                Checkbox(
                  value: searchTypeOptions.subjectExact,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.subjectExact = value!;
                      searchTypeOptions.subjectSubstring = false;
                    });
                  },
                ),
                const SizedBox(width: 12),
                const Text('Subject Substring'),
                Checkbox(
                  value: searchTypeOptions.subjectSubstring,
                  onChanged: (bool? value) {
                    setState(() {
                      searchTypeOptions.subjectSubstring = value!;
                      searchTypeOptions.subjectExact = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buttonRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Uri url = Uri.parse(
                  'https://www.loc.gov/standards/iso639-2/php/code_list.php');
              launchUrlForLanguageCodes(url);
            },
            child: const Text('Visit web page for language codes'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: clearSearchEntries,
            child: const Text('Clear search entries'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              getDocs(isNewQuery: true);
            },
            child: const Text('Get book documents'),
          ),
          const SizedBox(width: 50),
          ElevatedButton(
            onPressed:
                (_page == 0) || ((_pageLimit > 0) && (_page == _pageLimit))
                    ? null
                    : () {
                        _page++;
                        getDocs(isNewQuery: false);
                      },
            child: const Text('Next page'),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: _page <= 1
                ? null
                : () {
                    if (_page > 1) {
                      _page--;
                      getDocs(isNewQuery: false);
                    }
                  },
            child: const Text('Previous page'),
          ),
        ],
      ),
    );
  }
}
