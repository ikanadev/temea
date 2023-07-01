import 'package:flutter/material.dart';
import 'package:temea/utils/utils.dart';

@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  final String id;
  final String name;
  final CategoryColor color;
  final DateTime createdAt;

  Category copyWith({String? name, CategoryColor? color, DateTime? createdAt}) {
    return Category(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
