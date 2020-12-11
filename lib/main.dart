import 'package:flutter/material.dart';
import 'package:pokedex/src/di/module.dart';

import 'src/app.dart';

void main() {
  setUpPokemonOfficialApi();
  setUpData();
  setUpDomain();
  runApp(PokedexApp());
}
