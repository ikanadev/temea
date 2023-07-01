import 'package:flutter/material.dart';
import 'package:temea/utils/is_dark_mode.dart';

enum CategoryColor {
  pink,
  red,
  orange,
  deepOrange,
  amber,
  yellow,
  lime,
  lightGreen,
  green,
  teal,
  cyan,
  lightBlue,
  blue,
  indigo,
  purple,
  deepPurple,
  blueGrey,
  brown,
  grey,
}

const Map<CategoryColor, Color> _lightColorsMap = {
  CategoryColor.pink: Colors.pink,
  CategoryColor.red: Colors.red,
  CategoryColor.orange: Colors.orange,
  CategoryColor.deepOrange: Colors.deepOrange,
  CategoryColor.amber: Colors.amber,
  CategoryColor.yellow: Colors.yellow,
  CategoryColor.lime: Colors.lime,
  CategoryColor.lightGreen: Colors.lightGreen,
  CategoryColor.green: Colors.green,
  CategoryColor.teal: Colors.teal,
  CategoryColor.cyan: Colors.cyan,
  CategoryColor.lightBlue: Colors.lightBlue,
  CategoryColor.blue: Colors.blue,
  CategoryColor.indigo: Colors.indigo,
  CategoryColor.purple: Colors.purple,
  CategoryColor.deepPurple: Colors.deepPurple,
  CategoryColor.blueGrey: Colors.blueGrey,
  CategoryColor.brown: Colors.brown,
  CategoryColor.grey: Colors.grey,
};
const Map<CategoryColor, Color> _darkColorsMap = {
  CategoryColor.pink: Colors.pink,
  CategoryColor.red: Colors.red,
  CategoryColor.orange: Colors.orange,
  CategoryColor.deepOrange: Colors.deepOrange,
  CategoryColor.amber: Colors.amber,
  CategoryColor.yellow: Colors.yellow,
  CategoryColor.lime: Colors.lime,
  CategoryColor.lightGreen: Colors.lightGreen,
  CategoryColor.green: Colors.green,
  CategoryColor.teal: Colors.teal,
  CategoryColor.cyan: Colors.cyan,
  CategoryColor.lightBlue: Colors.lightBlue,
  CategoryColor.blue: Colors.blue,
  CategoryColor.indigo: Colors.indigo,
  CategoryColor.purple: Colors.purple,
  CategoryColor.deepPurple: Colors.deepPurple,
  CategoryColor.blueGrey: Colors.blueGrey,
  CategoryColor.brown: Colors.brown,
  CategoryColor.grey: Colors.grey,
};

Color getCatColor(
    {required CategoryColor color, required BuildContext context}) {
  Color matColor = Colors.grey;
  if (isDarkMode(context)) {
    matColor = _darkColorsMap[color] ?? Colors.grey;
  } else {
    matColor = _lightColorsMap[color] ?? Colors.grey;
  }
  return matColor;
}
