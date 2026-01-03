import 'package:code_judge/l10n/app_localizations.dart';
import 'package:code_judge/main.dart';
import 'package:code_judge/ui_elements/my_alert_dialog.dart';
import 'package:code_judge/ui_elements/my_edit_text.dart';
import 'package:flutter/material.dart';

class TrainingsMode extends StatefulWidget{
  String task;
  String solution;
  String hint;
  
  TrainingsMode({
    required this.task,
    required this.solution,
    required this.hint,
  });

  @override
  State<TrainingsMode> createState() => _TrainingsModeState();
}

class _TrainingsModeState extends State<TrainingsMode> {
  late TextEditingController enterCodeController;
  String programmingLanguage = ".c";
  String textBoxMessage = "";

  @override
  void initState() {
    super.initState();
    // Set the controller
    enterCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.trainingsMode), // Trainings mode
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          // Scrollable area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline, width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.task, // The task
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        FloatingActionButton.small(
                          child: Icon(Icons.lightbulb_outline),
                          onPressed: (){
                            MyAlertDialog().showHintDialog(
                              context,
                              appLocalizations.dialogHint, // Hint
                              widget.hint,
                              appLocalizations.alertClose, // Close
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyEditText(
                    hint: appLocalizations.enterCodeHint, // Enter your code...
                    controller: enterCodeController,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // Container is pinned to the bottom of the window
          Divider(thickness: 1, height: 1),
          Container(
            padding: const EdgeInsets.all(12),
            color: theme.colorScheme.surfaceContainerHigh,
            child: Row(
              children: [
                Text(textBoxMessage),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: programmingLanguage,
                          items: const [
                            DropdownMenuItem(value: ".c", child: Text("C")),
                            DropdownMenuItem(value: ".go", child: Text("Go")),
                            DropdownMenuItem(value: ".py", child: Text("Python")),
                            DropdownMenuItem(value: ".cpp", child: Text("C++")),
                            DropdownMenuItem(value: ".rs", child: Text("Rust")),
                            DropdownMenuItem(value: ".rb", child: Text("Ruby")),
                            DropdownMenuItem(value: ".js", child: Text("JavaScript")),
                            DropdownMenuItem(value: ".php", child: Text("PHP")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              programmingLanguage = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                FloatingActionButton.extended(
                  label: Text(appLocalizations.done), // Done
                  icon: Icon(Icons.done_all),
                  onPressed: () {
                    String userCode = enterCodeController.text;
                    // Call library and check it's result
                    String resultByJudger = judgerLib.callJudger(userCode, programmingLanguage, widget.solution);

                    // If the result is an error message display it in the lower left Text()
                    if (resultByJudger.startsWith("ERROR:")) {
                      setState(() {
                        textBoxMessage = resultByJudger;
                      });
                    // Else open a Dialog an tell the user about it's result
                    } else {
                      MyAlertDialog().showTrainingSuccessfullDialog(context, int.parse(resultByJudger.trimLeft()));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    // Close the controller as well
    enterCodeController.dispose();
    super.dispose();
  }
}
