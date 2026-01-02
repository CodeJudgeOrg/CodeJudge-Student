import 'package:code_juge/l10n/app_localizations.dart';
import 'package:code_juge/main.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  void showTrainingSuccessfullDialog(BuildContext context, int score){
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: score == 100 ? false : true,
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
            TextButton(
              child: Text(appLocalizations.alertClose), // Close
              onPressed: () {
                Navigator.pop(context);
                // Return home
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageLayoutHandler()),
                );
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

}
