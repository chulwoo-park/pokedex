import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex/src/domain/common/page.dart' as _i2;
import 'package:pokedex/src/domain/news/repository.dart' as _i3;
import 'dart:async' as _i4;
import 'package:pokedex/src/domain/news/entity.dart' as _i5;
import 'package:pokedex/src/data/news/data_source.dart' as _i6;
import 'package:pokedex/src/domain/news/usecase.dart' as _i7;

class _FakePage<T> extends _i1.Fake implements _i2.Page<T> {}

/// A class which mocks [PageKey].
///
/// See the documentation for Mockito's code generation for more information.
class MockPageKey extends _i1.Mock implements _i2.PageKey {
  MockPageKey() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [NewsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsRepository extends _i1.Mock implements _i3.NewsRepository {
  MockNewsRepository() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> getNewsList(_i2.PageKey? pageKey,
          {bool? useCache = true}) =>
      super.noSuchMethod(
          Invocation.method(#getNewsList, [pageKey], {#useCache: useCache}),
          Future.value(_FakePage<_i5.News>()));
}

/// A class which mocks [RemoteNewsSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteNewsSource extends _i1.Mock implements _i6.RemoteNewsSource {
  MockRemoteNewsSource() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> getNewsList(_i2.PageKey? pageKey) =>
      super.noSuchMethod(Invocation.method(#getNewsList, [pageKey]),
          Future.value(_FakePage<_i5.News>()));
}

/// A class which mocks [LocalNewsSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalNewsSource extends _i1.Mock implements _i6.LocalNewsSource {
  MockLocalNewsSource() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<void> setNewsList(
          _i2.PageKey? pageKey, _i2.Page<_i5.News>? page) =>
      super.noSuchMethod(
          Invocation.method(#setNewsList, [pageKey, page]), Future.value(null));
  _i4.Future<_i2.Page<_i5.News>> getNewsList(_i2.PageKey? pageKey) =>
      super.noSuchMethod(Invocation.method(#getNewsList, [pageKey]),
          Future.value(_FakePage<_i5.News>()));
}

/// A class which mocks [GetNewsList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNewsList extends _i1.Mock implements _i7.GetNewsList {
  MockGetNewsList() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> call([_i7.GetNewsListParams? params]) =>
      super.noSuchMethod(Invocation.method(#call, [params]),
          Future.value(_FakePage<_i5.News>()));
}

/// A class which mocks [RefreshNewsList].
///
/// See the documentation for Mockito's code generation for more information.
class MockRefreshNewsList extends _i1.Mock implements _i7.RefreshNewsList {
  MockRefreshNewsList() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Page<_i5.News>> call([void _]) => super.noSuchMethod(
      Invocation.method(#call, []), Future.value(_FakePage<_i5.News>()));
}

/// A class which mocks [Exception].
///
/// See the documentation for Mockito's code generation for more information.
class MockException extends _i1.Mock implements Exception {
  MockException() {
    _i1.throwOnMissingStub(this);
  }
}
