import 'package:dio/dio.dart';

import '../../data/news/data_source.dart';
import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';
import 'model.dart';

class NewsApi implements RemoteNewsSource {
  const NewsApi(this.dio);

  final Dio dio;

  /// ex) /us/api/news/?index=0&count=6
  @override
  Future<Page<News>> getNewsList(PageKey? pageKey) {
    var index = 0;
    var count = 20;
    if (pageKey != null && pageKey is NewsPageKey) {
      index = pageKey.index;
      count = pageKey.count;
    }

    return dio.get(
      '/us/api/news/',
      queryParameters: {
        'index': index,
        'count': count,
      },
    ).then((res) {
      return Page(
        items: (res.data as List).cast<Map<String, dynamic>>().map((e) {
          if (e['externalClass'] == '') {
            e.remove('externalClass');
          }

          if (e.containsKey('url')) {
            e['url'] = dio.options.baseUrl + e['url'];
          }

          return NewsVO.fromJson(e).toEntity();
        }).toList(),
        prevKey: index - count > 0 ? NewsPageKey(index - count, count) : null,
        nextKey: NewsPageKey(index + count, count),
      );
    });
  }
}

class NewsPageKey implements PageKey {
  const NewsPageKey(this.index, this.count);

  final int index;
  final int count;
}
