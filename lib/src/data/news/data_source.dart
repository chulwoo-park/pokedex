import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';

// ignore: one_member_abstracts
abstract class LocalNewsSource {
  Future<void> setNewsList(PageKey? pageKey, Page<News> page);

  Future<Page<News>> getNewsList(PageKey? pageKey);
}

// ignore: one_member_abstracts
abstract class RemoteNewsSource {
  Future<Page<News>> getNewsList(PageKey? pageKey);
}
