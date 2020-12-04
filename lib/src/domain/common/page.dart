import 'package:equatable/equatable.dart';

class Page<T> extends Equatable {
  const Page({
    this.items = const [],
    this.prevKey,
    this.nextKey,
    this.totalCount,
  });

  const Page.empty() : this();

  final List<T> items;
  final PageKey? nextKey;
  final PageKey? prevKey;
  final int? totalCount;

  @override
  List<Object?> get props => [items, nextKey, prevKey, totalCount];
}

abstract class PageKey {}
