import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_provider.g.dart';

@riverpod
class Page extends _$Page {
  @override
  int build() {
    return 1;
  }

  void incrementPage() => state++;

  void decrementPage() => state--;
}
