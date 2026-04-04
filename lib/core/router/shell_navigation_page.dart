import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/core/router/widgets/shell_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellNavigationPage extends StatelessWidget {
  const ShellNavigationPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShellAppBar(currentIndex: navigationShell.currentIndex),
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTabChanged: (tab) {
          navigationShell.goBranch(
            tab.index,
            initialLocation: tab.index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
