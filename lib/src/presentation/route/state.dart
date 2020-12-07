import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class RouteState extends Equatable {
  const RouteState(this.pages);

  final List<Page> pages;

  @override
  List<Object?> get props => [pages];
}
