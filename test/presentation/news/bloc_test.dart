import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/usecase.dart';
import 'package:pokedex/src/presentation/common/state.dart';

import '../../domain/mock.dart';
import '../../given_when_then/given_when_then.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([GetNewsList])
void main() {
  group('NewsBloc', () {
    final newsPage = Page(items: [News(id: 0, title: 'News')]);

    final GetNewsList getNewsList = MockGetNewsList();
    final bloc = NewsListBloc(getNewsList);

    testThat(
      given(
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
      given(
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
      given(
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
