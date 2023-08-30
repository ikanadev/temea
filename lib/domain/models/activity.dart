import 'package:flutter/material.dart';
import 'models.dart';

@immutable
class Activity {
  final int uuid;
  final String name;
  final String iconName;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? deletedAt;
  final Category? category;

  const Activity({
    required this.uuid,
    required this.name,
    required this.createdAt,
    required this.iconName,
    this.startedAt,
    this.deletedAt,
    this.category,
  });

  Activity copyWith(
    String? name,
    String? iconName,
    DateTime? startedAt,
    DateTime? deletedAt,
  ) {
    return Activity(
      uuid: uuid,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt,
      startedAt: startedAt ?? this.startedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
