import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../route/model.dart';

class HomeScreen extends StatelessWidget {
  static RouteConfig get route => RouteConfig(
        path: '/',
        builder: () => HomeScreen(),
      );

  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('what pokemon\nare you looking for?'),
          Text('Search Pokemon, Move, Ability etc'),
          Text('Pokedex'),
          Text('Moves'),
          Text('Abilities'),
          Text('Items'),
          Text('Locations'),
          Text('Type Charts'),
        ],
      ),
    );
  }
}
