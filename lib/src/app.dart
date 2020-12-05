import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/src/presentation/screen/home.dart';

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
