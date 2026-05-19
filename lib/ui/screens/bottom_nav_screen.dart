import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:to_do_list/core/constants/app_colors.dart';

class BottomNavScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavScreen({super.key, required this.navigationShell});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.neutralColor),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => widget.navigationShell.goBranch(index),
        items: [
          _buildBottomNavItem(
            isWidth: true,
            icon: Icons.task,
            label: 'Tasks',
            color: null,
          ),
          _buildBottomNavItem(
            isWidth: true,
            icon: Icons.bar_chart,
            label: 'Stats',
            color: null,
          ),
          _buildBottomNavItem(
            isWidth: true,
            icon: Icons.settings,
            label: 'Settings',
            color: null,
          ),
        ],
      ),
    );
  }

  //phần bottom nav
  SalomonBottomBarItem _buildBottomNavItem({
    required bool isWidth,
    required IconData icon,
    String? label,
    Color? color,
  }) {
    return SalomonBottomBarItem(
      unselectedColor: AppColors.tertiaryColor.withOpacity(0.5),
      activeIcon: Icon(icon, color: AppColors.primaryColor),
      icon: Icon(icon),
      title: isWidth ? Text(label ?? '') : SizedBox(),
      selectedColor: color ?? AppColors.primaryColor,
    );
  }
}
