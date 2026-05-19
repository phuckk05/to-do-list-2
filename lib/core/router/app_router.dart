import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list/core/router/app_router_name.dart';
import 'package:to_do_list/core/router/app_router_path.dart';
import 'package:to_do_list/ui/screens/bottom_nav_screen.dart';
import 'package:to_do_list/ui/screens/settings_screen.dart';
import 'package:to_do_list/ui/screens/stats_screen.dart';
import 'package:to_do_list/ui/screens/tasks_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(BuildContext context) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouterPath.tasks,
    routes: [
      // GoRoute(
      //   name: AppRouterName.root,
      //   path: AppRouterPath.root,
      //   builder: (context, state) => Scaffold(
      //     body: Center(child: Text('Welcome to the To-Do List App!')),
      //   ),
      // ),

      // App routes sau khi đăng nhập
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouterName.tasks,
                path: AppRouterPath.tasks,
                builder: (context, state) => TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouterName.stats,
                path: AppRouterPath.stats,
                builder: (context, state) => StatsScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouterName.settings,
                path: AppRouterPath.settings,
                builder: (context, state) => SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
