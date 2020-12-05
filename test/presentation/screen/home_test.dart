import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/presentation/screen/home.dart';

import '../../given_when_then/widget_given_when_then.dart';

void main() {
  group('HomeScreen', () {
    final screen = MaterialApp(home: HomeScreen());

    final title = 'what pokemon\nare you looking for?';
    final searchText = 'Search Pokemon, Move, Ability etc';
    testWidget(
      when(
        'i enters the home screen',
        (tester) => tester.pumpWidget(screen),
      )
          .then(
            'i can see $title',
            () => expect(find.text(title), findsOneWidget),
          )
          .and(
            'i can see $searchText',
            () => expect(find.text(searchText), findsOneWidget),
          )
          .and(
            'i can see Pokedex card',
            () => expect(find.text('Pokedex'), findsOneWidget),
          )
          .and(
            'i can see Moves card',
            () => expect(find.text('Moves'), findsOneWidget),
          )
          .and(
            'i can see Abilities card',
            () => expect(find.text('Abilities'), findsOneWidget),
          )
          .and(
            'i can see Items card',
            () => expect(find.text('Items'), findsOneWidget),
          )
          .and(
            'i can see Locations card',
            () => expect(find.text('Locations'), findsOneWidget),
          )
          .and(
            'i can see Type Charts card',
            () => expect(find.text('Type Charts'), findsOneWidget),
          ),
    );
  });
}
