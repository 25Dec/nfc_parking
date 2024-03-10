import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../res/app_colors.dart';
import '../../routes/app_route_constants.dart';

class ShellPage extends StatefulWidget {
  final Widget child;

  const ShellPage({
    super.key,
    required this.child,
  });

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _currPageIndex = 0;

  final List<Widget> _destinations = const [
    NavigationDestination(
      icon: Icon(FluentIcons.card_ui_24_regular),
      selectedIcon: Icon(FluentIcons.card_ui_24_filled),
      label: "Cards",
    ),
    NavigationDestination(
      icon: Icon(FluentIcons.history_24_regular),
      selectedIcon: Icon(FluentIcons.history_24_filled),
      label: "History",
    ),
    if (true)
      NavigationDestination(
        icon: Icon(FluentIcons.people_24_regular),
        selectedIcon: Icon(FluentIcons.people_24_filled),
        label: "Staff",
      ),
    NavigationDestination(
      icon: Icon(FluentIcons.settings_24_regular),
      selectedIcon: Icon(FluentIcons.settings_24_filled),
      label: "Settings",
    ),
  ];

  void _onDestinationSelected(BuildContext context, int index) {
    setState(() => _currPageIndex = index);

    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(AppPage.nfcCardsShell.toName);
      case 1:
        GoRouter.of(context).goNamed(AppPage.parkingHistoryShell.toName);
      case 2:
        GoRouter.of(context).goNamed(AppPage.staff.toName);
      case 3:
        GoRouter.of(context).goNamed(AppPage.settings.toName);
      default:
        GoRouter.of(context).goNamed(AppPage.nfcCardsShell.toName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        height: 65,
        elevation: 1,
        backgroundColor: AppColors.white2,
        selectedIndex: _currPageIndex,
        onDestinationSelected: (index) => _onDestinationSelected(context, index),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: _destinations,
      ),
    );
  }
}
