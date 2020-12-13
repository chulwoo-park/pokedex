import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' show Mock, any;
import 'package:pokedex/src/di/module.dart';
import 'package:pokedex/src/domain/news/usecase.dart';
import 'package:pokedex/src/presentation/route/router.dart';
import 'package:pokedex/src/presentation/screen/home/home.dart';

import '../../given_when_then/widget_given_when_then.dart';
import '../../test.mocks.dart';

void main() {
  group('Route', () {
    testThat(
      () {
        final repo = MockNewsRepository();
        mockWhen(repo.getNewsList(any)).thenThrow(Exception());
        getIt.registerSingleton<GetNewsList>(GetNewsList(repo));

        return when('i enter the app', (tester) async {
          await tester.pumpWidget(
            MaterialApp.router(
              theme: ThemeData.light(),
              routerDelegate: AppRouterDelegate(),
              routeInformationParser: AppRouteInformationParser(),
            ),
          );
        }).then('i can see home screen', () {
          /// You'd also want to be sure that your page is now
          /// present in the screen.
          expect(find.byType(HomeScreen), findsOneWidget);
        });
      },
    );
  });
}
