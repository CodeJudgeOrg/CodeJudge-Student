import 'package:code_juge/main.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  void showTrainingSuccessfullDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          // TODO Implement translation!
          title: Text("Success!"),
          content: Text("Your Score..."),
          actions: [
            TextButton(
              // TODO Implement translation!
              child: Text("Leave"),
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
}