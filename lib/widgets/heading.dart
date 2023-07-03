import 'package:flutter/material.dart';
import 'package:temea/utils/constants.dart';

class Heading extends StatelessWidget implements PreferredSizeWidget {
  const Heading({super.key, this.title = appName});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), centerTitle: true);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
