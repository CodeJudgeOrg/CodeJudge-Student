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

import 'package:code_judge/l10n/app_localizations.dart';
import 'package:code_judge/main.dart';
import 'package:code_judge/pages/settings_page.dart';
import 'package:code_judge/ui_elements/my_infomation_right_sheet.dart';
import 'package:code_judge/ui_elements/my_list_items.dart';
import 'package:code_judge/ui_elements/my_navigation_bar.dart';
import 'package:code_judge/utils/global_variables.dart';
import 'package:code_judge/utils/my_exercises.dart';
import 'package:code_judge_library/exercise_datamodel.dart';
import 'package:flutter/material.dart';

class Desktoplayout extends StatefulWidget{
  @override
  State<Desktoplayout> createState() => _DesktoplayoutState();
}

class _DesktoplayoutState extends State<Desktoplayout> {
  Widget getSelectedPage() {
    switch (selectedIndexInNavigationBar) {
      case 0:
        return ExercisePage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyNavigationBar(
      screenType: ScreenType.desktop,
      selectedIndex: selectedIndexInNavigationBar,
      onItemSelected:(index) {
        // Normal navigation
        if (index != 1) {
          setState(() {
            selectedIndexInNavigationBar = index;
          });
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }
      },
      body: getSelectedPage(),
      items: getNavigationBarItems(context),
    );
  }
}

// Home Page showing all exercises
class ExercisePage extends StatelessWidget{
  // Display the correct exercises
  List<ExerciseDatamodel> items = MyExercises().getAllExercises();

  ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          // Display a list of exercises
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: List.generate(
                items.length,
                (index) {
                  return MyDesktopAndTabletItem(
                    title: items[index].name,
                    note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
                    onTap: (){
                      // Open an overlay showing further informations
                      OpenMyRightSheet.openMyRightSheet(context, items[index].name, items[index].description, items[index].task, items[index].hint, items[index].solution, 500);
                    }
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}