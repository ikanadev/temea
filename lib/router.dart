import 'package:go_router/go_router.dart';
import 'package:temea/screens/category/category.dart';
import 'package:temea/screens/stats/stats.dart';
import 'package:temea/screens/activities/activities.dart';
import 'package:temea/screens/home/home.dart';

final router = GoRouter(
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
);
