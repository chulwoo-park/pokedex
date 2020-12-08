import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/home/home.dart';
import 'event.dart';
import 'model.dart';
import 'router.dart';
import 'state.dart';

const String kRootPath = '/';

Widget buildRootPage() => HomeScreen();

const kRootConfig = RouteConfig(
  path: kRootPath,
  builder: buildRootPage,
);

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc(this.parser)
      : super(
          RouteState([
            kRootConfig.createPage(key: _homeKey),
          ]),
        );

  final RoutePathParser parser;

  static const LocalKey _homeKey = ValueKey(kRootPath);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouteConfig get currentRoute => parser.parse(state.pages.last.name);

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) {
    if (event is Push) {
      return _mapPushEventToState(event.config);
    } else if (event is Pop) {
      return _mapPopEventToState(event.route);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<RouteState> _mapPushEventToState(RouteConfig config) async* {
    if (config.path == kRootPath) {
      state.pages.removeWhere((element) => element.key != _homeKey);
    } else {
      state.pages.add(config.createPage());
    }

    yield RouteState(state.pages);
  }

  Stream<RouteState> _mapPopEventToState(Route<dynamic> route) async* {
    state.pages.remove(route.settings);

    yield RouteState(state.pages);
  }
}
