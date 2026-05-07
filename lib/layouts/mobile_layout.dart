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
import 'package:code_judge/pages/settings_page.dart';
import 'package:code_judge/ui_elements/my_infomation_right_sheet.dart';
import 'package:code_judge/utils/api_connector.dart';
import 'package:code_judge/utils/global_variables.dart';
import 'package:code_judge/utils/my_provider.dart';
import 'package:code_judge_library/code_judge_button_menu.dart';
import 'package:code_judge_library/code_judge_list_items.dart';
import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:code_judge_library/datamodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mobilelayout extends StatefulWidget{
  const Mobilelayout({super.key});

  @override
  State<Mobilelayout> createState() => _MobilelayoutState();
}

class _MobilelayoutState extends State<Mobilelayout> {
  Widget getSelectedPage() {
    switch (selectedIndexInNavigationBar) {
      case 0:
        return ExercisePage();
      case 1:
        return SubmissionPage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CodeJudgeNavigationBar(
      screenType: CodeJudgeScreenType.mobile,
      selectedIndex: selectedIndexInNavigationBar,
      onItemSelected:(index) {
        // Normal navigation
        if (index != 2) {
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
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    // Display the correct exercises
    List<ExerciseDatamodel> items = context.watch<ExerciseProvider>().exercises;

    return Scaffold(
      body: Column(
        children: [
          // Display a list of exercises
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return CodeJudgeMobileItem(
                  title: items[index].name,
                  note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
                  isSelected: items[index].isSelected,
                  onTap: (){
                    if (items[index].isSelected) {
                      // Deselect the exercise and return
                      context.read<ExerciseProvider>().toggleSelectionOfExercise(index, false);
                      return;
                    }
                    // Open an overlay showing further informations
                    OpenMyRightSheet.openMyRightSheet(context, items[index].name, items[index].description, items[index].task, items[index].hint, items[index].solution, 300);
                  },
                  onLongPress: (details) {
                    // Mark this exercise as selected
                    context.read<ExerciseProvider>().toggleSelectionOfExercise(index, true);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Button in the lower right corner
      floatingActionButton: CodeJudgeButtonMenu(
        show: context.read<ExerciseProvider>().showSelectionBar,
        icon: Icons.sync_outlined,
        label: appLocalizations.syncExercises, // "Synchronise"
        onDeselectPressed: () => context.read<ExerciseProvider>().unselectAllExercises(), // Unselect all selected exercises
        onUploadPressed: () {}, // TODO
        onDeletePressed: () {}, // TODO
        onButtonPressed: () {
          // Sync the exercises
          ApiConnector().receiveExercises(context);
        },
      ),
    );
  }
}

// Page showing all submissions
class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<SubmissionDatamodel> submissions = context.watch<SubmissionProvider>().submissions;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: submissions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return CodeJudgeMobileItem(
                  title: submissions[index].exerciseName,
                  note: submissions[index].task,
                  onTap: () {
                    // TODO: If time, add a screen to edit a submission
                  },
                );
              },
            ),
          )
        ],
      ),
    );
    // TODO: Display a list of exercises, that have been submitted
    // => Right-Click -> Submit -> Submit and add the exercise to this list, remove it from the old one
  }
}
