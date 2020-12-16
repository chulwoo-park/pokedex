import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/src/di/module.dart';
import 'package:pokedex/src/domain/common/page.dart';
import 'package:pokedex/src/domain/news/entity.dart';
import 'package:pokedex/src/domain/news/usecase.dart';
import 'package:pokedex/src/presentation/screen/home/home.dart';

import '../../given_when_then/widget_given_when_then.dart';
import '../../test.mocks.dart';

void main() {
  group('HomeScreen', () {
    testThat(
      () {
        final repo = MockNewsRepository();
        getIt.registerSingleton<GetNewsList>(GetNewsList(repo));
        getIt.registerSingleton<RefreshNewsList>(RefreshNewsList(repo));

        final screen = MaterialApp(home: HomeScreen());

        final title = 'What pokemon\nare you looking for?';
        final searchText = 'Search Pokemon, Move, Ability etc';

        return given('empty news data', () {
          mockWhen(repo.getNewsList(any))
              .thenAnswer((_) async => Page<News>.empty());
        })
            .when(
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
            )
            .and(
          'i can see News list',
          (tester) {
            expect(
              find.text('Pokémon News', skipOffstage: false),
              findsOneWidget,
            );
          },
        ).and(
          'i can see empty news message',
          (tester) async {
            await tester.pump();
            expect(
              find.text('There is no news today.', skipOffstage: false),
              findsOneWidget,
            );
          },
        );
      },
    );
  });
}
