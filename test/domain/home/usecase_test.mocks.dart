import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex/src/domain/common/page.dart' as _i2;
import 'package:pokedex/src/domain/news/repository.dart' as _i3;
import 'dart:async' as _i4;
import 'package:pokedex/src/domain/news/entity.dart' as _i5;

class _FakePage<T> extends _i1.Fake implements _i2.Page<T> {}

/// A class which mocks [NewsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsRepository extends _i1.Mock implements _i3.NewsRepository {
  MockNewsRepository() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> getNewsList(_i2.PageKey? pageKey) =>
      super.noSuchMethod(Invocation.method(#getNewsList, [pageKey]),
          Future.value(_FakePage<_i5.News>()));
}
