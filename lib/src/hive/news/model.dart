import 'package:hive/hive.dart';

import '../common/identified.dart';

@HiveType(typeId: 3)
class HiveNews extends HiveObject with Identified<int> {
  HiveNews(
    this.id,
    this.title,
    this.thumbnailUrl,
    this.summary,
    this.createdAt,
  );

  @HiveField(0)
  @override
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? thumbnailUrl;
  @HiveField(3)
  final String? summary;
  @HiveField(4)
  final DateTime createdAt;
}
