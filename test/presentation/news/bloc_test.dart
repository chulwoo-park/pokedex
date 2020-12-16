import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/usecase.dart';
import 'package:pokedex/src/presentation/common/state.dart';
import 'package:pokedex/src/presentation/news/bloc.dart';
import 'package:pokedex/src/presentation/news/event.dart';

import '../../given_when_then/given_when_then.dart';
import '../../test.mocks.dart';

void main() {
  group('NewsBloc', () {
    final newsPage = Page(items: [News(id: 0, title: 'News')]);

    final GetNewsList getNewsList = MockGetNewsList();
    final RefreshNewsList refreshNewsList = MockRefreshNewsList();

    final bloc = NewsListBloc(
      refreshNewsList,
      getNewsList,
    );

    testThat(
      () => given(
        'some news list',
        () => mockWhen(refreshNewsList()).thenAnswer((_) async => newsPage),
      )
          .when(
            'request news list with [refresh] to true',
            () => bloc.add(NewsListRequested(refresh: true)),
          )
          .then(
            'the news list is loaded',
            () => expectLater(
              bloc,
              emitsInOrder([
                Loading(),
                LoadSuccess(newsPage),
              ]),
            ),
          ),
    );

    testThat(
      () => given(
        'some news list',
        () => mockWhen(getNewsList()).thenAnswer((_) async => newsPage),
      )
          .when(
            'request news list',
            () => bloc.add(NewsListRequested()),
          )
          .then(
            'the news list is loaded.',
            () => expectLater(
              bloc,
              emitsInOrder([
                Loading(),
                LoadSuccess(newsPage),
              ]),
            ),
          ),
    );

    testThat(
      () => given(
        'empty list',
        () =>
            mockWhen(getNewsList()).thenAnswer((_) async => Page<News>.empty()),
      )
          .when(
            'request news list',
            () => bloc.add(NewsListRequested()),
          )
          .then(
            'the empty list is loaded',
            () => expectLater(
              bloc,
              emitsInOrder([
                Loading(),
                LoadSuccess(Page<News>.empty()),
              ]),
            ),
          ),
    );

    testThat(
      () => given(
        'an error',
        () => mockWhen(getNewsList())
            .thenAnswer((_) => Future.error(MockException(), StackTrace.empty)),
      )
          .when(
            'request news list',
            () => bloc.add(NewsListRequested()),
          )
          .then(
            'state changed to failure',
            () => expectLater(
              bloc,
              emitsInOrder([
                Loading(),
                LoadFailure(MockException(), StackTrace.empty),
              ]),
            ),
          ),
    );
  });
}

@immutable
class MockException implements Exception {
  @override
  bool operator ==(Object other) {
    return other is MockException;
  }

  @override
  int get hashCode => 37;
}
