import 'package:code_juge/main.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final Widget body;
  final ScreenType screenType;
  final String title;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  // Labels for the navigation
  final List<MyNavigationBarItemData> items;

  const MyNavigationBar({
    super.key,
    required this.body,
    required this.screenType,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.title = 'CodeJudge',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (screenType == ScreenType.desktop) {
      // Big NavigationBar for desktops
      return Scaffold(
        body: Row(
          children: [
            Container(
              color: theme.colorScheme.surface,
              width: 200,
              child: Column(
                children: [
                  // Render all items except the last one
                  for (int i = 0; i < items.length - 1; i++)
                    MyNavigationBarItem(
                      icon: items[i].icon,
                      label: items[i].label,
                      selected: selectedIndex == i,
                      onTap: () => onItemSelected(i),
                  ),
                  // Push the last item to the bottom (settings)
                  const Spacer(),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 4),
                    child: Divider(
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  MyNavigationBarItem(
                    icon: items.last.icon,
                    label: items.last.label,
                    selected: selectedIndex == items.length - 1,
                    onTap: () => onItemSelected(items.length - 1),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: body),
          ],
        ),
      );
    } else if (screenType == ScreenType.tablet) {
      // Small NavigationBar for tablets
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: theme.colorScheme.surface,
              selectedIndex: selectedIndex,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: onItemSelected,
              destinations: [
                for (final item in items)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    label: Text(item.label),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: body),
          ],
        ),
      );
    } else {
      // Overlay on mobile devices
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
        drawer: Drawer(
          backgroundColor: theme.colorScheme.surface,
          child: Column(
            children: [
              const DrawerHeader(child: Text('CodeJudge')),
              Expanded(
                child: Column(
                  children: [
                    // List all items except the last one
                    for (int i = 0; i < items.length - 1; i++)
                      MyNavigationBarItem(
                        icon: items[i].icon,
                        label: items[i].label,
                        selected: selectedIndex == i,
                        onTap: () => onItemSelected(i),
                    ),
                    // Push the last item to the bottom (settings)
                    const Spacer(),
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 4),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    MyNavigationBarItem(
                      icon: items.last.icon,
                      label: items.last.label,
                      selected: selectedIndex == items.length - 1,
                      onTap: () => onItemSelected(items.length - 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: body,
      );
    }
  }
}

// Data per item
class MyNavigationBarItemData {
  final IconData icon;
  final String label;

  const MyNavigationBarItemData({
    required this.icon,
    required this.label,
  });
}

// Design of an item
class MyNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const MyNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected
          ? theme.colorScheme.surfaceContainerHighest
          : theme.colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}