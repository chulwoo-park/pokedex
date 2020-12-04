import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/mockito.dart' as mockito show when;
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
    final localPage = Page(items: [News(title: 'local')]);
    final remotePage = Page(items: [News(title: 'remote')]);

    testThat(
      given('non-null local data', () {
        mockWhen(localNewsSource.getNewsList(pageKey))
            .thenAnswer((_) async => localPage);
      }).and('non-null remote data', () {
        mockWhen(remoteNewsSource.getNewsList(pageKey))
            .thenAnswer((_) async => remotePage);
      }).when('call getNewsList', () async {
        return repository.getNewsList(pageKey);
      }).then('use local data', (result) async {
        expectLater(result, completion(localPage));
      }),
    );

    testThat(
      given('null local data', () {
        mockWhen(localNewsSource.getNewsList(pageKey))
            .thenAnswer((_) async => Future.error(Exception()));
      }).and('non-null remote data', () {
        mockWhen(remoteNewsSource.getNewsList(pageKey))
            .thenAnswer((_) async => remotePage);
      }).when('call getNewsList', () {
        return repository.getNewsList(pageKey);
      }).then('use remote data', (result) {
        expectLater(result, completion(remotePage));
      }).and('find local data source first', () {
        verifyInOrder([
          localNewsSource.getNewsList(pageKey),
          remoteNewsSource.getNewsList(pageKey),
        ]);
      }),
    );

    testThat(
      given('null page key', () {
        mockWhen(localNewsSource.getNewsList(null))
            .thenAnswer((_) async => Future.error(Exception()));
        mockWhen(remoteNewsSource.getNewsList(null))
            .thenAnswer((_) async => remotePage);
      }).when('call getNewsList', () {
        return repository.getNewsList(null);
      }).then('success', (result) {
        expectLater(result, completion(remotePage));
      }),
    );
  });
}
