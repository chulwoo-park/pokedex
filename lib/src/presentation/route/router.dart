import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'model.dart';

// ignore: one_member_abstracts
abstract class RoutePathParser {
  RouteConfig parse(String? path);
}

class AppRouterDelegate extends RouterDelegate<RouteConfig>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<RouteConfig> {
  AppRouterDelegate({RoutePathParser parser = const DefaultPathParser()})
      : _bloc = RouteBloc(parser);

  final RouteBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Navigator(
        key: navigatorKey,
        onPopPage: _handleOnPopPage,
        pages: _bloc.state.pages,
      ),
    );
  }

  bool _handleOnPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (didPop) {
      _bloc.add(Pop(route));
    }

    return didPop;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _bloc.navigatorKey;

  @override
  RouteConfig get currentConfiguration => _bloc.currentRoute;

  @override
  Future<void> setNewRoutePath(RouteConfig configuration) async {
    // TODO: check future sync
    _bloc.add(Push(configuration));
  }
}

class AppRouteInformationParser extends RouteInformationParser<RouteConfig> {
  const AppRouteInformationParser({this.parser = const DefaultPathParser()});

  final RoutePathParser parser;

  @override
  Future<RouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    return parser.parse(routeInformation.location);
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfig configuration) {
    return RouteInformation(location: configuration.path);
  }
}

class DefaultPathParser implements RoutePathParser {
  const DefaultPathParser();

  @override
  RouteConfig parse(String? path) {
    final uri = Uri.parse(path ?? '/');

    if (uri.pathSegments.isEmpty) {
      return kRootConfig;
    }

    return RouteConfig.unknown();
  }
}
