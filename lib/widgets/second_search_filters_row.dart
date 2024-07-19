import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/doc_filters_provider.dart';

class SecondSearchFiltersRow extends ConsumerStatefulWidget {
  final DocFiltersClass docFilters;

  const SecondSearchFiltersRow({
    super.key,
    required this.docFilters,
  });

  @override
  ConsumerState<SecondSearchFiltersRow> createState() =>
      _SecondSearchFiltersRowState();
}

class _SecondSearchFiltersRowState
    extends ConsumerState<SecondSearchFiltersRow> {
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
              const SizedBox(width: 60),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  children: [
                    const Text('Person Exact'),
                    Checkbox(
                      value: docFilters.personExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.personExact = value!;
                          docFilters.personSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 15),
                    const Text('Person Substring'),
                    Checkbox(
                      value: docFilters.personSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.personSubstring = value!;
                          docFilters.personExact = false;
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
                      value: docFilters.placeExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.placeExact = value!;
                          docFilters.placeSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text('Place Substring'),
                    Checkbox(
                      value: docFilters.placeSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.placeSubstring = value!;
                          docFilters.placeExact = false;
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
                      value: docFilters.subjectExact,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.subjectExact = value!;
                          docFilters.subjectSubstring = false;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text('Subject Substring'),
                    Checkbox(
                      value: docFilters.subjectSubstring,
                      onChanged: (bool? value) {
                        setState(() {
                          docFilters.subjectSubstring = value!;
                          docFilters.subjectExact = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
