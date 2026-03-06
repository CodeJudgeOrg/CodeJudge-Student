/// Copyright 2026 Fabian Roland (naibaf-1)

/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at

/// http://www.apache.org/licenses/LICENSE-2.0

/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

library;

import 'package:code_judge/l10n/app_localizations.dart';
import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:flutter/material.dart';

int selectedIndexInNavigationBar = 0;

List<MyNavigationBarItemData> getNavigationBarItems(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;

  return [
    MyNavigationBarItemData(icon: Icons.code, label: appLocalizations.exercises), // Exercises
    MyNavigationBarItemData(icon: Icons.settings, label: appLocalizations.settings), // Settings
  ];
}
