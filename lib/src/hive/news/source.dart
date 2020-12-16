import 'dart:convert';

import '../../data/news/data_source.dart';
import '../../domain/common/page.dart';
import '../../domain/news/entity.dart';
import '../cache/cache.dart';

class HiveNewsSource implements LocalNewsSource {
  const HiveNewsSource();

  static const boxName = 'news';

  @override
  Future<Page<News>> getNewsList(PageKey? pageKey) {
    return HiveCache.instance
        .get(boxName, pageKey?.toString() ?? 'all')
        .then((cache) => Page(
              items: (cache.data['items']).map<News>(
                (e) {
                  final json = Map<String, dynamic>.from(e);
                  return News(
                    id: json['id'],
                    title: json['title'],
                    thumbnailUrl: json['thumbnailUrl'],
                    summary: json['summary'],
                    createdAt: json['createdAt'],
                  );
                },
              ).toList(),
              totalCount: cache.data['totalCount'],
              // page key
            ));
  }

  @override
  Future<void> setNewsList(PageKey? pageKey, Page<News> page) async {
    return HiveCache.instance.save(
      boxName,
      {
        'items': page.items
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'thumbnailUrl': e.thumbnailUrl,
                  'summary': e.summary,
                  'createdAt': e.createdAt,
                })
            .toList(),
        'totalCount': page.totalCount,
        'prevKey': page.prevKey.toString(),
        'nextKey': page.nextKey.toString(),
      },
      key: pageKey?.toString() ?? 'all',
    );
  }
}
