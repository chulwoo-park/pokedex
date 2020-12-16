import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';
import '../../domain/news/repository.dart';
import 'data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this._localNewsSource, this._remoteNewsSource);

  final LocalNewsSource _localNewsSource;
  final RemoteNewsSource _remoteNewsSource;

  @override
  Future<Page<News>> getNewsList(
    PageKey? pageKey, {
    bool useCache = true,
  }) async {
    Future<Page<News>> job;
    if (useCache) {
      job = _localNewsSource
          .getNewsList(pageKey)
          .catchError((_) => _remoteNewsSource.getNewsList(pageKey));
    } else {
      job = _remoteNewsSource.getNewsList(pageKey);
    }

    return job.then((page) => _caching(pageKey, page));
  }

  Future<Page<News>> _caching(PageKey? pageKey, Page<News> page) async {
    await _localNewsSource.setNewsList(pageKey, page);
    return page;
  }
}
