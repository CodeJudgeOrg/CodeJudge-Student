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
import 'package:code_judge_library/code_judge_list_items.dart';
import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:code_judge_library/code_judge_selection_app_bar.dart';
import 'package:code_judge_library/datamodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Desktoplayout extends StatefulWidget{
  const Desktoplayout({super.key});
  @override
  State<Desktoplayout> createState() => _DesktoplayoutState();
}

class _DesktoplayoutState extends State<Desktoplayout> {
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
      screenType: CodeJudgeScreenType.desktop,
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
      appBar: CodeJudgeSelectionAppBar(
        show: context.watch<ExerciseProvider>().showSelectionBar,
        title: appLocalizations.selectionAppBarTitle, // "Selection"
        onClosePressed: () => context.read<ExerciseProvider>().unselectAllExercises(),
        onUploadPressed: () {},
        onDeletePressed: () {}
      ),
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
                  return CodeJudgeDesktopAndTabletItem(
                    title: items[index].name,
                    note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
                    isSelected: items[index].isSelected,
                    onTap: (){
                      if(items[index].isSelected){
                        // Deselect the item and return
                        context.read<ExerciseProvider>().toggleSelectionOfExercise(index, false);
                        return;
                      }

                      // Open an overlay showing further informations
                      OpenMyRightSheet.openMyRightSheet(context, items[index].name, items[index].description, items[index].task, items[index].hint, items[index].solution, 500);
                    },
                    onLongPress: (details) {
                      // Mark this exercise as selected
                      context.read<ExerciseProvider>().toggleSelectionOfExercise(index, true);
                    },
                  );
                }
              ),
            )
          ),
        ],
      ),
      // Button to sync with the server
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.sync_outlined),
        label: Text(appLocalizations.syncExercises), // "Synchronise"
        onPressed: (){
          // Update the list of exercises
          ApiConnector().receiveExercises(context);
        }
      ),
    );
  }
}

// Page showing all submissions
class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Display a list of submissions
    List<SubmissionDatamodel> items = context.watch<SubmissionProvider>().submissions;

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
                  return CodeJudgeDesktopAndTabletItem(
                    title: items[index].exerciseName,
                    note: items[index].task,
                    onTap: (){
                      // TODO: If time, add a screen to edit a submission
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