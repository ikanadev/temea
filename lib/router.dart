import 'package:go_router/go_router.dart';
import 'package:temea/screens/screens.dart';
import 'package:temea/widgets/widgets.dart';

final router = GoRouter(
  initialLocation: '/tracker',
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
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tracker',
              builder: (context, state) => const TrackerScreen(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/log',
              builder: (context, state) => const LogScreen(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const StatsScreen(),
            )
          ],
        ),
      ],
    ),
  ],
);
