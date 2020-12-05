import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/data/news/data_source.dart';
import 'package:pokedex/src/data/news/repository.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';

import '../../domain/mock.dart';
import '../../given_when_then/given_when_then.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([LocalNewsSource, RemoteNewsSource])
void main() {
  group('NewsRepositoryImpl', () {
    final localNewsSource = MockLocalNewsSource();
    final remoteNewsSource = MockRemoteNewsSource();
    final repository = NewsRepositoryImpl(localNewsSource, remoteNewsSource);

    final pageKey = MockPageKey();

    final localPage = Page(items: [News(id: 0, title: 'local')]);
    final remotePage = Page(items: [News(id: 1, title: 'remote')]);

    final givenNonNullLocalData = given(
      'non-null local data',
      () => mockWhen(localNewsSource.getNewsList(any))
          .thenAnswer((_) async => localPage),
    );

    final givenNullLocalData = given(
      'null local data',
      () => mockWhen(localNewsSource.getNewsList(any))
          .thenAnswer((_) => Future.error(Exception())),
    );

    final givenNonNullRemoteData = given(
      'non-null remote data',
      () => mockWhen(remoteNewsSource.getNewsList(any))
          .thenAnswer((_) async => remotePage),
    );

    testThat(
      givenNonNullLocalData
          .andThat(givenNonNullRemoteData)
          .when(
            'get news list',
            () => repository.getNewsList(pageKey),
          )
          .then(
            'return data using local data',
            (result) => expectLater(result, completion(localPage)),
          ),
    );

    testThat(
      givenNullLocalData
          .andThat(givenNonNullRemoteData)
          .when(
            'get news list',
            () => repository.getNewsList(pageKey),
          )
          .then(
            'return data using remote data',
            (result) => expectLater(result, completion(remotePage)),
          )
          .and(
            'find local data source first',
            () => verifyInOrder([
              localNewsSource.getNewsList(pageKey),
              remoteNewsSource.getNewsList(pageKey),
            ]),
          ),
    );

    testThat(
      givenNonNullLocalData
          .when(
            'get news list with null parameter',
            () => repository.getNewsList(null),
          )
          .then(
            'page loaded',
            (result) => expectLater(result, completion(localPage)),
          ),
    );
  });
}
