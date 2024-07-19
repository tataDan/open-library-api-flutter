import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/doc_filters_provider.dart';

class FirstSearchFiltersRow extends ConsumerStatefulWidget {
  final DocFiltersClass docFilters;

  const FirstSearchFiltersRow({
    super.key,
    required this.docFilters,
  });

  @override
  ConsumerState<FirstSearchFiltersRow> createState() =>
      _FirstSearchFiltersRowState();
}

class _FirstSearchFiltersRowState extends ConsumerState<FirstSearchFiltersRow> {
  @override
  Widget build(BuildContext context) {
    DocFiltersClass docFilters = ref.watch(docFiltersProvider);
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 10.0),
          Row(
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
                      value: docFilters.titleExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.titleExact = value!;
                          docFilters.titleSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text('Title Substring'),
                    Checkbox(
                      value: docFilters.titleSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.titleSubstring = value!;
                          docFilters.titleExact = false;
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
                      value: docFilters.authorExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.authorExact = value!;
                          docFilters.authorSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text('Author Substring'),
                    Checkbox(
                      value: docFilters.authorSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.authorSubstring = value!;
                          docFilters.authorExact = false;
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
                      value: docFilters.publisherExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.publisherExact = value!;
                          docFilters.publisherSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text('Publisher Substring'),
                    Checkbox(
                      value: docFilters.publisherSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.publisherSubstring = value!;
                          docFilters.publisherExact = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
