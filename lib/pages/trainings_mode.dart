import 'package:code_juge/main.dart';
import 'package:code_juge/ui_elements/my_alert_dialog.dart';
import 'package:code_juge/ui_elements/my_edit_text.dart';
import 'package:flutter/material.dart';

class TrainingsMode extends StatelessWidget{
  String workOrder;
  
  TrainingsMode({
    required this.workOrder
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int programmingLanguage = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trainings mode"),
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
                      workOrder,
                      softWrap: true,
                    ),
                  ),

                  const SizedBox(height: 16),

                  MyEditText(
                    hint: "Enter code...",
                    onInputDone: (value) {},
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
                const Text("ERROR: xyz"),
                const Spacer(),

                // TODO Implement translation
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ProgrammingLanguageSelector(programmingLanguage: programmingLanguage),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                FloatingActionButton.extended(
                  // TODO Call C backend => Handle output
                  // TODO Implement translation
                  label: Text("Done"),
                  icon: Icon(Icons.done_all),
                  onPressed: () {
                    MyAlertDialog().showTrainingSuccessfullDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

// Selector for switching between the available programming languages
class ProgrammingLanguageSelector extends StatefulWidget{
  int programmingLanguage;

  ProgrammingLanguageSelector({
    required this.programmingLanguage
  });

  @override
  State<ProgrammingLanguageSelector> createState() => _ProgrammingLanguageSelectorState();
}
class _ProgrammingLanguageSelectorState extends State<ProgrammingLanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: widget.programmingLanguage,
        items: const [
          DropdownMenuItem(value: 0, child: Text("C")),
          DropdownMenuItem(value: 1, child: Text("Python")),
          DropdownMenuItem(value: 2, child: Text("Java")),
          DropdownMenuItem(value: 3, child: Text("C++")),
        ],
        onChanged: (value) {
          setState(() {
            widget.programmingLanguage = value!;
          });
        },
      ),
    );
  }
}