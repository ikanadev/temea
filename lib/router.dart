import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:temea/screens/category/category.dart';
import 'package:temea/widgets/app_shell.dart';
import 'package:temea/screens/stats/stats.dart';
import 'package:temea/screens/activities/activities.dart';
import 'package:temea/screens/home/home.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/activities',
          builder: (context, state) => const ActivitiesScreen(),
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoryScreen(),
        ),
        GoRoute(
          path: '/stats',
          builder: (context, state) => const StatsScreen(),
        ),
      ],
    ),
  ],
);
