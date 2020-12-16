import 'package:hive/hive.dart';

import '../../domain/common/exception.dart';
import 'model.dart';

// TODO: improvement caching
class HiveCache {
  HiveCache._();

  static HiveCache instance = HiveCache._();

  Future<void> save(
    String boxName,
    Map<String, dynamic> json, {
    String? key,
  }) async {
    var box = await Hive.openBox<HiveCacheModel>(boxName);
    final cache = HiveCacheModel(json);
    if (key != null) {
      await box.put(key, cache);
    } else if (json.containsKey('id')) {
      await box.put(json['id'].toString(), cache);
    } else {
      await box.add(cache);
    }

    await box.close();
  }

  Future<HiveCacheModel> get(String boxName, String key) async {
    var box = await Hive.openBox<HiveCacheModel>(boxName);
    final HiveCacheModel? result = box.get(key);

    if (result == null) {
      throw CacheNotFound();
    }

    if (result.isExpired) {
      await box.delete(key);
      throw CacheNotFound();
    }
    await box.close();
    return result;
  }
}
