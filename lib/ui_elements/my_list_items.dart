import 'package:flutter/material.dart';

// Styled item for the GridView
class MyDesktopAndTabletItem extends StatelessWidget{
  final title;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  String note;

  MyDesktopAndTabletItem({
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.surfaceContainerHigh, // Ripple-color at click
        hoverColor: theme.colorScheme.surfaceContainer,  // Hover-color
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  note,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
// Styled item for the ListView
class MyMobileItem extends StatelessWidget {
  final title;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String note;

  MyMobileItem({
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.surfaceContainerHigh,
        hoverColor: theme.colorScheme.surfaceContainer,
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    note,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}