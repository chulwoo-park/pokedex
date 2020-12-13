import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/usecase.dart';

import '../../given_when_then/given_when_then.dart';
import '../../test.mocks.dart';

void main() {
  group('get news list test', () {
    final newsRepository = MockNewsRepository();
    final getNewsList = GetNewsList(newsRepository);

    final givenSomePages = given('some pages', () {
      mockWhen(newsRepository.getNewsList(null))
          .thenAnswer((_) async => Page<News>());
      mockWhen(newsRepository.getNewsList(any))
          .thenAnswer((_) async => Page<News>());
    });

    testThat(
      () => givenSomePages
          .when(
            'get news list without parameters',
            getNewsList,
          )
          .then(
            'page loaded',
            (result) => expect(result, Page<News>()),
          ),
    );

    testThat(
      () => givenSomePages
          .when(
            'get news list with null parameter',
            () => getNewsList(null),
          )
          .then(
            'page loaded',
            (result) => expect(result, Page<News>()),
          ),
    );

    testThat(
      () => givenSomePages
          .when(
            'get news list any parameter',
            () => getNewsList(GetNewsListParams(MockPageKey())),
          )
          .then(
            'page loaded',
            (result) => expect(result, Page<News>()),
          ),
    );

    testThat(
      () => givenSomePages
          .when(
            'get news list',
            getNewsList,
          )
          .then(
            'get data from repository',
            () => verify(newsRepository.getNewsList(any)),
          ),
    );
  });
}
