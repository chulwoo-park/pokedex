import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/repository.dart';
import 'package:pokedex/src/domain/news/usecase.dart';

import '../../given_when_then/given_when_then.dart';
import '../mock.dart';
import 'usecase_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  group('GetNewsList test', () {
    final newsRepository = MockNewsRepository();
    final getNewsList = GetNewsList(newsRepository);

    final givenSomePages = given('some pages', () {
      mockWhen(newsRepository.getNewsList(null))
          .thenAnswer((_) async => Page<News>());
      mockWhen(newsRepository.getNewsList(any))
          .thenAnswer((_) async => Page<News>());
    });

    testThat(
      givenSomePages
          .when(
            'GetNewsList without parameters',
            getNewsList,
          )
          .then(
            'page loaded',
            (result) => expectLater(result, completion(Page<News>())),
          ),
    );

    testThat(
      givenSomePages
          .when(
            'GetNewsList with null parameter',
            () => getNewsList(null),
          )
          .then(
            'page loaded',
            (result) => expectLater(result, completion(Page<News>())),
          ),
    );

    testThat(
      givenSomePages
          .when(
            'GetNewsList any parameter',
            () => getNewsList(GetNewsListParams(MockPageKey())),
          )
          .then(
            'page loaded',
            (result) => expectLater(result, completion(Page<News>())),
          ),
    );

    testThat(
      givenSomePages
          .when(
            'GetNewsList',
            getNewsList,
          )
          .then(
            'get data from repository',
            () => verify(newsRepository.getNewsList(any)),
          ),
    );
  });
}
