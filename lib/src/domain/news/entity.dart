import 'package:equatable/equatable.dart';

class News extends Equatable {
  final int id;
  final String title;
  final String? thumbnailUrl;
  final String? summary;
  final DateTime createdAt;

  News({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    this.summary,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object> get props => [id];
}
