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
import 'package:code_judge/pages/trainings_mode.dart';
import 'package:flutter/material.dart';

class OpenMyRightSheet {
  // Open the RightSheet and fill it with the correct content
  static void openMyRightSheet(BuildContext context, String exerciseName, String description, String task, String hint, String solution, double width){
    final appLocalizations = AppLocalizations.of(context)!;

    MyRightSheet().showRightSheet(
      context, 
      Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              elevation: 8,
              color: Theme.of(context).colorScheme.surface,
              child: SizedBox(
                width: width,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(appLocalizations.rightSheetDetails + exerciseName), // Details
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(description),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Button to add new menu cards
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.play_circle),
                label: Text(appLocalizations.rightSheetStart), // Start
                onPressed: () {
                  // Start the training
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingsMode(task: task, hint: hint, solution: solution)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Overlay at the right side of the window showing some informations about an exercise
class MyRightSheet{
  void showRightSheet(BuildContext context, Widget child) {
    final theme = Theme.of(context);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context)!.rightSheetDetails, // Details
      barrierColor: theme.colorScheme.scrim.withAlpha(128),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0), // Start at the right side
          end: Offset.zero,          // End: normal position
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
