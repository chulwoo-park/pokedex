import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';
import '../../domain/news/repository.dart';
import 'data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this._localNewsSource, this._remoteNewsSource);

  final LocalNewsSource _localNewsSource;
  final RemoteNewsSource _remoteNewsSource;

  @override
  Future<Page<News>> getNewsList(PageKey? pageKey) async {
    return _localNewsSource.getNewsList(pageKey).catchError(
          (e) => _remoteNewsSource
              .getNewsList(pageKey)
              .then((page) => _saveToLocal(pageKey, page)),
        );
  }

  Future<Page<News>> _saveToLocal(PageKey? pageKey, Page<News> page) async {
    await _localNewsSource.setNewsList(pageKey, page);
    return page;
  }
}
