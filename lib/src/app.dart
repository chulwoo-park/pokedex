import 'package:flutter/material.dart';

import 'presentation/route/router.dart';

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}
