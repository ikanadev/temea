import 'package:flutter/material.dart';

import 'icons/material.dart';

IconData getMaterialIconData(String name) {
  if (materialIconMap.containsKey(name)) {
    return materialIconMap[name]!;
  }
  return materialIconMap['square_rounded']!;
}
