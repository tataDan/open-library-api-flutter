import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../models/response.dart';
import '../providers/filtered_docs_provider.dart';
import '../providers/page_provider.dart';
import '../providers/response_provider.dart';
import '../show_options.dart';
import '../url_launchers.dart';

class DocumentsPage extends ConsumerStatefulWidget {
  const DocumentsPage({super.key});

  @override
  ConsumerState<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends ConsumerState<DocumentsPage> {
  var showOptions = ShowOptions(
    showAuthor: true,
    showPublisher: true,
    showPerson: true,
    showPlace: true,
    showSubject: true,
    showIsbn: true,
    showLanguage: true,
  );

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Response> response = ref.watch(responseProvider);

    if (response.hasError) {
      return const Center(
        child: Text('ERROR: You might not have a internet connection!'),
      );
    }

    if (response.value == null) {
      return const SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final int page = ref.watch(pageProvider);
    final List<Doc> filterDocs = ref.watch(filterDocsProvider);
    int itemCount = 0;

    if (filterDocs.isNotEmpty) {
      itemCount = filterDocs.length;
    } else {
      itemCount = response.value!.docs.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents Page'),
      ),
      body: Column(
        children: [
          if (response.value!.docs.isEmpty)
            const Center(
              child: Text(
                'NO DOCUMENTS FOUND! Either the query did not find any documents or the server is down.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          showOptionsRow(),
          if (response.value != null) showPageRow(response.value!, page, ref),
          const Divider(),
          switch (response) {
            AsyncData(:final value) => Expanded(
                child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      return showDoc(index, value);
                    }),
              ),
            AsyncError() =>
              const Center(child: Text('Oops, something unexpected happened')),
            _ => const Center(
                child: CircularProgressIndicator(),
              ),
          }
        ],
      ),
    );
  }

  Padding showOptionsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        direction: Axis.horizontal,
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
          const SizedBox(width: 10),
          const Text('Publisher'),
          Checkbox(
            value: showOptions.showPublisher,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPublisher = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          const Text('Person'),
          Checkbox(
            value: showOptions.showPerson,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPerson = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          const Text('Place'),
          Checkbox(
            value: showOptions.showPlace,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showPlace = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          const Text('Subject'),
          Checkbox(
            value: showOptions.showSubject,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showSubject = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          const Text('ISBN'),
          Checkbox(
            value: showOptions.showIsbn,
            onChanged: (bool? value) {
              setState(() {
                showOptions.showIsbn = value!;
              });
            },
          ),
          const SizedBox(width: 10),
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
          ElevatedButton(
              onPressed: () {
                setState(() {
                  showOptions.showAll();
                });
              },
              child: const Text('Set All Options')),
          const SizedBox(width: 15),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  showOptions.hideAll();
                });
              },
              child: const Text('Hide All Options')),
        ],
      ),
    );
  }

  Padding showPageRow(Response value, int page, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          Text(
            'Page: $page',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: page > (value.numFound / docsPerPage)
                ? null
                : () {
                    ref.read(pageProvider.notifier).incrementPage();
                  },
            child: const Text('Next Page'),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: page <= 1
                ? null
                : () {
                    ref.read(pageProvider.notifier).decrementPage();
                  },
            child: const Text('Previous Page'),
          ),
          const SizedBox(width: 20.0),
          Text(
            'Unfiltered documents: ${value.numFound.toString()}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Padding showDoc(int index, Response value) {
    List<Doc> docs = ref.watch(filterDocsProvider);

    if (docs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Document filtered out'),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (index == 0)
              ? const SizedBox(height: 0.0)
              : const SizedBox(height: 8.0),
          Text(
            'Document #${index + 1}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 2.0),
          Row(
            children: [
              const Text('Title:'),
              const SizedBox(width: 6),
              Expanded(child: Text(docs[index].title)),
            ],
          ),
          Row(
            children: [
              const Text('Subtitle:'),
              const SizedBox(width: 6),
              docs[index].subtitle != null
                  ? Expanded(child: Text(docs[index].subtitle!))
                  : const Text(''),
            ],
          ),
          if (docs[index].authorName != null && showOptions.showAuthor) ...[
            for (var author in docs[index].authorName!)
              Row(
                children: [
                  const Text('Author:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(author)),
                ],
              ),
          ] else ...[
            const Text('Authors:')
          ],
          if (docs[index].publisher != null && showOptions.showPublisher) ...[
            for (var publisher in docs[index].publisher!)
              Row(
                children: [
                  const Text('Publisher:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(publisher)),
                ],
              ),
          ] else ...[
            const Text('Publishers:')
          ],
          if (docs[index].person != null && showOptions.showPerson) ...[
            for (var person in docs[index].person!)
              Row(
                children: [
                  const Text('Person:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(person)),
                ],
              ),
          ] else ...[
            const Text('Persons:'),
          ],
          if (docs[index].place != null && showOptions.showPlace) ...[
            for (var place in docs[index].place!)
              Row(
                children: [
                  const Text('Place:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(place)),
                ],
              ),
          ] else ...[
            const Text('Places:'),
          ],
          if (docs[index].subject != null && showOptions.showSubject) ...[
            for (var subject in docs[index].subject!)
              Row(
                children: [
                  const Text('Subject:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(subject)),
                ],
              ),
          ] else ...[
            const Text('Subjects:'),
          ],
          if (docs[index].isbn != null && showOptions.showIsbn) ...[
            for (var isbn in docs[index].isbn!)
              Row(
                children: [
                  const Text('ISBN:'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(isbn)),
                ],
              ),
          ] else ...[
            const Text('ISBNs:'),
          ],
          if (docs[index].language != null && showOptions.showLanguage) ...[
            for (var language in docs[index].language!)
              Row(
                children: [
                  const Text('Language::'),
                  const SizedBox(width: 6),
                  Expanded(child: Text(language)),
                ],
              ),
          ] else ...[
            const Text('Languages:'),
          ],
          Row(
            children: [
              const Text('Key:'),
              const SizedBox(width: 6),
              Text(docs[index].key),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Uri url = Uri.parse('https://openlibrary.org/${docs[index].key}');
              launchUrlForBook(url);
            },
            child: const Text('Visit web page for this book'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
