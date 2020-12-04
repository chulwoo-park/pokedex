import '../common/page.dart';
import 'entity.dart';

// ignore: one_member_abstracts
abstract class NewsRepository {
  Future<Page<News>> getNewsList(PageKey? pageKey);
}
