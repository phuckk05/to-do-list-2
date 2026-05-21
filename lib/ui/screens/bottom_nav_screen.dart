import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavScreen({super.key, required this.navigationShell});
  //mở showbottomsheet

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    debugPrint('Current route: $location');
    return Scaffold(
      body: navigationShell,

      // bottomNavigationBar: SalomonBottomBar(
      //   currentIndex: navigationShell.currentIndex,
      //   onTap: (index) => navigationShell.goBranch(index),
      //   items: [
      //     _buildBottomNavItem(
      //       isWidth: true,
      //       icon: Icons.task,
      //       label: 'Tasks',
      //       color: null,
      //     ),
      //     _buildBottomNavItem(
      //       isWidth: true,
      //       icon: Icons.bar_chart,
      //       label: 'Stats',
      //       color: null,
      //     ),
      //     _buildBottomNavItem(
      //       isWidth: true,
      //       icon: Icons.settings,
      //       label: 'Settings',
      //       color: null,
      //     ),
      //   ],
      // ),
    );
  }

  //phần bottom nav
  // SalomonBottomBarItem _buildBottomNavItem({
  //   required bool isWidth,
  //   required IconData icon,
  //   String? label,
  //   Color? color,
  // }) {
  //   return SalomonBottomBarItem(
  //     unselectedColor: AppColors.tertiaryColor.withOpacity(0.5),
  //     activeIcon: Icon(icon, color: AppColors.primaryColor),
  //     icon: Icon(icon),
  //     title: isWidth ? Text(label ?? '') : SizedBox(),
  //     selectedColor: color ?? AppColors.primaryColor,
  //   );
  // }
}
