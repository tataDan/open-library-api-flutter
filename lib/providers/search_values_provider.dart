import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_values_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchValues extends _$SearchValues {
  @override
  Map<String, String> build() {
    return {};
  }

  void update(Map<String, String> searchValues) {
    state = searchValues;
  }
}
