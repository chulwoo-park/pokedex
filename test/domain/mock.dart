import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/domain/common/page.dart';

class MockPageKey extends Mock implements PageKey {}

@immutable
class MockException implements Exception {
  @override
  bool operator ==(Object other) {
    return other is MockException;
  }

  @override
  int get hashCode => 37;
}
