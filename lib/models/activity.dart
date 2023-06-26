import 'package:flutter/material.dart';
import 'package:temea/models/models.dart';

@immutable
class Activity {
  const Activity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.startedAt,
    this.deletedAt,
    this.category,
  });

  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? deletedAt;
  final Category? category;

  Activity copyWith(
    String? name,
    DateTime? startedAt,
    DateTime? createdAt,
    DateTime? deletedAt,
  ) {
    return Activity(
      id: id,
      name: name ?? this.name,
      startedAt: startedAt ?? this.startedAt,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
