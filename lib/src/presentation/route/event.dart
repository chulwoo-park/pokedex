import 'package:flutter/widgets.dart';

import 'model.dart';

abstract class RouteEvent {}

class Push implements RouteEvent {
  const Push(this.config);

  final RouteConfig config;
}

class Pop implements RouteEvent {
  const Pop(this.route);

  final Route<dynamic> route;
}
