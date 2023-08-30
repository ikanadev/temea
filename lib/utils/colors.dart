import 'package:flutter/material.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/utils/is_dark_mode.dart';

final Map<CategoryColor, Color> _lightColorsMap = {
  CategoryColor.pink: Colors.pink,
  CategoryColor.red: Colors.red,
  CategoryColor.orange: Colors.orange.shade700,
  CategoryColor.deepOrange: Colors.deepOrange.shade600,
  CategoryColor.amber: Colors.amber.shade800,
  CategoryColor.yellow: Colors.yellow.shade900,
  CategoryColor.lime: Colors.lime.shade800,
  CategoryColor.lightGreen: Colors.lightGreen.shade700,
  CategoryColor.green: Colors.green.shade700,
  CategoryColor.teal: Colors.teal.shade600,
  CategoryColor.cyan: Colors.cyan.shade600,
  CategoryColor.lightBlue: Colors.lightBlue.shade600,
  CategoryColor.blue: Colors.blue.shade600,
  CategoryColor.indigo: Colors.indigo.shade600,
  CategoryColor.purple: Colors.purple.shade600,
  CategoryColor.deepPurple: Colors.deepPurple.shade600,
  CategoryColor.blueGrey: Colors.blueGrey.shade700,
  CategoryColor.brown: Colors.brown.shade700,
  CategoryColor.grey: Colors.grey.shade800,
};
final Map<CategoryColor, Color> _darkColorsMap = {
  CategoryColor.pink: Colors.pink.shade400,
  CategoryColor.red: Colors.red.shade400,
  CategoryColor.orange: Colors.orange.shade400,
  CategoryColor.deepOrange: Colors.deepOrange.shade400,
  CategoryColor.amber: Colors.amber.shade400,
  CategoryColor.yellow: Colors.yellow.shade400,
  CategoryColor.lime: Colors.lime.shade400,
  CategoryColor.lightGreen: Colors.lightGreen.shade400,
  CategoryColor.green: Colors.green.shade400,
  CategoryColor.teal: Colors.teal.shade400,
  CategoryColor.cyan: Colors.cyan.shade400,
  CategoryColor.lightBlue: Colors.lightBlue.shade400,
  CategoryColor.blue: Colors.blue.shade400,
  CategoryColor.indigo: Colors.indigo.shade300,
  CategoryColor.purple: Colors.purple.shade300,
  CategoryColor.deepPurple: Colors.deepPurple.shade300,
  CategoryColor.blueGrey: Colors.blueGrey.shade400,
  CategoryColor.brown: Colors.brown.shade300,
  CategoryColor.grey: Colors.grey.shade400,
};

Color getCatColor({
  required CategoryColor color,
  required BuildContext context,
}) {
  Color matColor = Colors.grey;
  if (isDarkMode(context)) {
    matColor = _darkColorsMap[color] ?? Colors.grey;
  } else {
    matColor = _lightColorsMap[color] ?? Colors.grey;
  }
  return matColor;
}
