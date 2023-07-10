import 'package:flutter/material.dart';

import 'icons/material.dart';

const defaultIconName = 'square_rounded';

const iconsMap = materialIconMap;

IconData getIconData(String name) {
  if (materialIconMap.containsKey(name)) {
    return materialIconMap[name]!;
  }
  return materialIconMap[defaultIconName]!;
}
