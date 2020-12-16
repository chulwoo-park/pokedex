import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 2)
class HiveCacheModel {
  HiveCacheModel(this.data)
      : expireDate = DateTime.now().add(Duration(days: 7));

  HiveCacheModel._(this.data, this.expireDate);

  @HiveField(0)
  final Map<String, dynamic> data;

  @HiveField(1)
  final DateTime expireDate;

  bool get isExpired => DateTime.now().isAfter(expireDate);
}
