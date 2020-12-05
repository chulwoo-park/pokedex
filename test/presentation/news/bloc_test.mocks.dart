import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex/src/domain/common/page.dart' as _i2;
import 'package:pokedex/src/domain/news/usecase.dart' as _i3;
import 'dart:async' as _i4;
import 'package:pokedex/src/domain/news/entity.dart' as _i5;

class _FakePage<T> extends _i1.Fake implements _i2.Page<T> {}

/// A class which mocks [GetNewsList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNewsList extends _i1.Mock implements _i3.GetNewsList {
  MockGetNewsList() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> call([_i3.GetNewsListParams? params]) =>
      super.noSuchMethod(Invocation.method(#call, [params]),
          Future.value(_FakePage<_i5.News>()));
}
