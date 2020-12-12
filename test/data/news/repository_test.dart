import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/data/news/repository.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';

import '../../given_when_then/given_when_then.dart';
import '../../test.mocks.dart';

void main() {
  group('NewsRepositoryImpl', () {
    final localNewsSource = MockLocalNewsSource();
    mockWhen(localNewsSource.setNewsList(any, any))
        .thenAnswer((_) => Future.value());
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
      () => givenNullLocalData
          .andThat(givenNonNullRemoteData)
          .when(
            'get news list',
            () => repository.getNewsList(pageKey),
          )
          .then(
            'then save remote data in local storage',
            (result) => verify(localNewsSource.setNewsList(any, any)),
          ),
    );

    testThat(
      () => givenNonNullLocalData
          .andThat(givenNonNullRemoteData)
          .when(
            'get news list',
            () => repository.getNewsList(pageKey),
          )
          .then(
            'return data using local data',
            (result) => expect(result, localPage),
          ),
    );

    testThat(
      () => givenNullLocalData
          .andThat(givenNonNullRemoteData)
          .when(
            'get news list',
            () => repository.getNewsList(pageKey),
          )
          .then(
            'return data using remote data',
            (result) => expect(result, remotePage),
          )
          .and(
            'find local data source first',
            () => verifyInOrder([
              localNewsSource.getNewsList(any),
              remoteNewsSource.getNewsList(any),
              localNewsSource.setNewsList(any, any),
            ]),
          ),
    );

    testThat(
      () => givenNonNullLocalData
          .when(
            'get news list with null parameter',
            () => repository.getNewsList(null),
          )
          .then(
            'page loaded',
            (result) => expect(result, localPage),
          ),
    );
  });
}
