import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
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
