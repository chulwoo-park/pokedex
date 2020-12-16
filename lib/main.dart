import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/di/module.dart';
import 'src/hive/cache/model.dart';

void main() async {
  // TODO init HiveSource
  await Hive.initFlutter();
  Hive.registerAdapter(HiveCacheModelAdapter());

  setUpPokemonOfficialApi();
  setUpData();
  setUpDomain();
  runApp(PokedexApp());
}
