import 'package:flutter/material.dart';
import 'package:temea/utils/constants.dart';

class Heading extends StatelessWidget implements PreferredSizeWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appName),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
