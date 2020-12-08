import 'package:flutter/material.dart';

import 'presentation/resources.dart';
import 'presentation/route/router.dart';

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.light,
      fontFamily: R.font.circularStd,
    );

    return MaterialApp.router(
      title: 'Pokedex',
      theme: theme.copyWith(
        iconTheme: theme.iconTheme.copyWith(
          color: R.color.licorice,
        ),
        textTheme: theme.textTheme.apply(
          bodyColor: R.color.licorice,
          displayColor: R.color.licorice,
        ),
      ),
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}
