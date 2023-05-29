import 'package:flutter/material.dart';
import 'package:temea/utils/constants.dart';

@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.color,
  });

  final String id;
  final String name;
  final CategoryColor color;

  Category copyWith({String? name, CategoryColor? color}) {
    return Category(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}
