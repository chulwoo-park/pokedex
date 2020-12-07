import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

typedef PageWidgetBuilder = Widget Function();

class RouteConfig extends Equatable {
  const RouteConfig({
    required this.path,
    required this.builder,
  });

  factory RouteConfig.root() => kRootConfig;

  factory RouteConfig.unknown() => RouteConfig(
        path: '/404',
        builder: () => Scaffold(),
      );

  final String path;
  final PageWidgetBuilder builder;

  Page<T> createPage<T>({LocalKey? key}) {
    return MaterialPage<T>(
      key: key ?? UniqueKey(),
      name: path,
      child: builder(),
    );
  }

  @override
  List<Object?> get props => [path, builder];
}
