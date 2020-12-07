import 'package:flutter/widgets.dart';

import 'model.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<AppRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(AppRoute configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation routeInformation) {
    // TODO: implement parseRouteInformation
    throw UnimplementedError();
  }
}
