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
import 'package:code_judge/utils/api_connector.dart';
import 'package:code_judge_library/datamodels.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  // Dialog showing the results
  void showTrainingSuccessfullDialog(BuildContext context, int score, ExerciseDatamodel exercise, String output, String code){
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(appLocalizations.alertSuccess), // Congratulations!
          // Display results with translation!
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display a small explanatory note
              Text(receiveTranslatedMessage(score, appLocalizations)),
              const SizedBox(height: 4),
              Text(appLocalizations.alertScore + score.toString()), // Your score: xy
            ],
          ),
          actions: [
            // Button to close with submission
            TextButton(
              child: Text(appLocalizations.closeAndSubmit), // "Close & submit"
              onPressed: (){
                // Submit the solution
                ApiConnector().uploadSubmission(context, SubmissionDatamodel(
                  exerciseName: exercise.name,
                  task: exercise.task,
                  code: code,
                  output: output,
                  studentName: "studentName" // TODO: Use the real one
                ));

                // Navigate home
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageLayoutHandler()));
              },
            ),
            // Button to close the dialog
            TextButton(
              child: Text(appLocalizations.alertClose), // Close
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Receive the message depending on the score
  String receiveTranslatedMessage(int score, AppLocalizations appLocalizations){
    if (score == 0) {
      return appLocalizations.result0; // The programm crashed without an output
    } else if (score == 25){
      return appLocalizations.result25; // The programm returned a wrong output & crashed then
    } else if (score == 50){
      return appLocalizations.result50; // The programm returned the correct output & crashed afterwards
    } else if (score == 75){
      return appLocalizations.result75; // The programm ran successfully, but the output was wrong
    } else if (score == 100){
      return appLocalizations.result100; // The programm ran successfulle & the output was correct as well!
    } else {
      return "ERROR: Unkown score";
    }
  }

  // Dialog showing hints
  void showHintDialog(BuildContext context, String title, String hint, String buttonLabel){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(hint),
          actions: [
            TextButton(
              child: Text(buttonLabel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }
}
