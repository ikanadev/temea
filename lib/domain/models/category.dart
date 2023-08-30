import 'package:flutter/material.dart';
import 'category_color.dart';

@immutable
class Category {
  final int uuid;
  final String name;
  final CategoryColor color;
  final DateTime createdAt;
  final DateTime? deletedAt;

  const Category({
    required this.uuid,
    required this.name,
    required this.color,
    required this.createdAt,
    this.deletedAt,
  });

  Category copyWith({String? name, CategoryColor? color, DateTime? deletedAt}) {
    return Category(
      uuid: uuid,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
