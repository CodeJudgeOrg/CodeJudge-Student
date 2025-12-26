library;

import 'package:code_juge/ui_elements/my_navigation_bar.dart';
import 'package:flutter/material.dart';

int selectedIndexInNavigationBar = 0;

List<MyNavigationBarItemData> getNavigationBarItems(BuildContext context) {
  // TODO Implement translations
  return [
    MyNavigationBarItemData(icon: Icons.code, label: "Exercises"),
    MyNavigationBarItemData(icon: Icons.settings, label: "Settings"),
  ];
}
