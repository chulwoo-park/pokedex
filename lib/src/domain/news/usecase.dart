import '../common/page.dart';
import '../common/usecase.dart';
import 'entity.dart';
import 'repository.dart';

class GetNewsListParams {
  final PageKey key;

  const GetNewsListParams(this.key);
}

class RefreshNewsList with FutureUseCase<void, Page<News>> {
  const RefreshNewsList(this._newsRepository);

  final NewsRepository _newsRepository;

  @override
  Future<Page<News>> call([_]) {
    return _newsRepository.getNewsList(null, useCache: false);
  }
}

class GetNewsList with FutureUseCase<GetNewsListParams, Page<News>> {
  const GetNewsList(this._newsRepository);

  final NewsRepository _newsRepository;

  @override
  Future<Page<News>> call([GetNewsListParams? params]) {
    return _newsRepository.getNewsList(params?.key);
  }
}
