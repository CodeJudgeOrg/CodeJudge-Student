import 'package:code_juge/l10n/app_localizations.dart';
import 'package:code_juge/main.dart';
import 'package:code_juge/ui_elements/my_edit_text.dart';
import 'package:flutter/material.dart';

class TrainingsMode extends StatefulWidget{
  String workOrder;
  
  TrainingsMode({
    required this.workOrder
  });

  @override
  State<TrainingsMode> createState() => _TrainingsModeState();
}

class _TrainingsModeState extends State<TrainingsMode> {
  late TextEditingController enterCodeController;
  int programmingLanguage = 0;

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
                      border: Border.all(
                        color: theme.colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.workOrder,
                      softWrap: true,
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
          BottomContainer(
            programmingLanguage: programmingLanguage,
            controller: enterCodeController,
            buttonLabel: appLocalizations.done, // Done
          )
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

class BottomContainer extends StatefulWidget{
  String buttonLabel;
  int programmingLanguage;
  TextEditingController controller;

  BottomContainer({
    required this.programmingLanguage,
    required this.controller,
    this.buttonLabel = "Done",
  });

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  String textBoxMessage = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
                    value: widget.programmingLanguage,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text("C")),
                      DropdownMenuItem(value: 1, child: Text("Python")),
                      DropdownMenuItem(value: 2, child: Text("Go")),
                      DropdownMenuItem(value: 3, child: Text("C++")),
                      DropdownMenuItem(value: 3, child: Text("Rust")),
                      DropdownMenuItem(value: 3, child: Text("Ruby")),
                      DropdownMenuItem(value: 3, child: Text("JavaScript")),
                      DropdownMenuItem(value: 3, child: Text("PHP")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        widget.programmingLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            label: Text(widget.buttonLabel), // Done
            icon: Icon(Icons.done_all),
            onPressed: () {
              String userCode = widget.controller.text;
              // Call library if available
              setState(() {
                textBoxMessage = judgerLib.callJudger(userCode, ".c", "42",);
              });
              //MyAlertDialog().showTrainingSuccessfullDialog(context, 100);
            },
          ),
        ],
      ),
    );
  }
}
