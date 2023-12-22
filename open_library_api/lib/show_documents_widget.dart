import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_library_api/response.dart';
import 'package:open_library_api/optionClasses/show_options.dart';
import 'package:open_library_api/url_launchers.dart';

class ShowDocumentsWidget extends StatefulWidget {
  const ShowDocumentsWidget({
    super.key,
    required this.futureResponse,
    required this.showOptions,
  });

  final Future<Response>? futureResponse;
  final ShowOptions showOptions;

  @override
  State<ShowDocumentsWidget> createState() => _ShowDocumentsWidgetState();
}

class _ShowDocumentsWidgetState extends State<ShowDocumentsWidget> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<Response>(
        future: widget.futureResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'No Documents Were Found on This Page',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Note: If you changed the query criteria and then clicked on the "Next page" button instead of the "Get book docutments" button,'
                    '\nthen please click on the "Get book documents" button.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }

            return CallbackShortcuts(
              bindings: <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.arrowUp): () {
                  _scrollController.animateTo(_scrollController.offset - 15,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
                const SingleActivator(LogicalKeyboardKey.arrowDown): () {
                  _scrollController.animateTo(_scrollController.offset + 15,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
                const SingleActivator(LogicalKeyboardKey.pageUp): () {
                  _scrollController.animateTo(_scrollController.offset - 250,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
                const SingleActivator(LogicalKeyboardKey.pageDown): () {
                  _scrollController.animateTo(_scrollController.offset + 250,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
                const SingleActivator(LogicalKeyboardKey.home): () {
                  _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
                const SingleActivator(LogicalKeyboardKey.end): () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 30),
                      curve: Curves.ease);
                },
              },
              child: Focus(
                focusNode: _focusNode,
                child: GestureDetector(
                  onTap: () {
                    _focusNode.requestFocus();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return showData(index, snapshot);
                    },
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Padding showData(int index, AsyncSnapshot<Response> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Document #${index + 1}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          if (index == 0) const SizedBox(height: 8),
          Row(
            children: [
              const Text('Title:'),
              const SizedBox(width: 6),
              Expanded(child: Text(snapshot.data!.docs[index].title)),
            ],
          ),
          Row(
            children: [
              const Text('Subtitle:'),
              const SizedBox(width: 6),
              snapshot.data!.docs[index].subtitle != null
                  ? Expanded(child: Text(snapshot.data!.docs[index].subtitle!))
                  : const Text(''),
            ],
          ),
          if (snapshot.data!.docs[index].authorName != null &&
              widget.showOptions.showAuthor) ...[
            for (var author in snapshot.data!.docs[index].authorName!)
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
          if (snapshot.data!.docs[index].publisher != null &&
              widget.showOptions.showPublisher) ...[
            for (var publisher in snapshot.data!.docs[index].publisher!)
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
          if (snapshot.data!.docs[index].person != null &&
              widget.showOptions.showPerson) ...[
            for (var person in snapshot.data!.docs[index].person!)
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
          if (snapshot.data!.docs[index].place != null &&
              widget.showOptions.showPlace) ...[
            for (var place in snapshot.data!.docs[index].place!)
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
          if (snapshot.data!.docs[index].subject != null &&
              widget.showOptions.showSubject) ...[
            for (var subject in snapshot.data!.docs[index].subject!)
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
          if (snapshot.data!.docs[index].isbn != null &&
              widget.showOptions.showIsbn) ...[
            for (var isbn in snapshot.data!.docs[index].isbn!)
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
          if (snapshot.data!.docs[index].language != null &&
              widget.showOptions.showLanguage) ...[
            for (var language in snapshot.data!.docs[index].language!)
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
              Text(snapshot.data!.docs[index].key),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Uri url = Uri.parse(
                  'https://openlibrary.org/${snapshot.data!.docs[index].key}');
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
