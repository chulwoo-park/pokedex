import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class HivePage<T extends HiveObject> {
  HivePage({
    required this.items,
    this.prevKey,
    this.nextKey,
    this.totalCount,
  });

  @HiveField(0)
  final List<T> items;

  @HiveField(1)
  final String? prevKey;

  @HiveField(2)
  final String? nextKey;

  @HiveField(3)
  final int? totalCount;
}
