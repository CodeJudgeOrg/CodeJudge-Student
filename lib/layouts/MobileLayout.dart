import 'package:code_juge/l10n/app_localizations.dart';
import 'package:code_juge/main.dart';
import 'package:code_juge/pages/settings_page.dart';
import 'package:code_juge/ui_elements/my_infomation_right_sheet.dart';
import 'package:code_juge/ui_elements/my_list_items.dart';
import 'package:code_juge/ui_elements/my_navigation_bar.dart';
import 'package:code_juge/ui_elements/my_search_bar.dart';
import 'package:code_juge/utils/exercise_datamodell.dart';
import 'package:code_juge/utils/global_variables.dart';
import 'package:code_juge/utils/my_exercises.dart';
import 'package:flutter/material.dart';

class Mobilelayout extends StatefulWidget{
  @override
  State<Mobilelayout> createState() => _MobilelayoutState();
}

class _MobilelayoutState extends State<Mobilelayout> {
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
      screenType: ScreenType.mobile,
      selectedIndex: selectedIndexInNavigationBar,
      onItemSelected:(index) {
        // Normal navigation
        if (index != 1) {
          setState(() {
            selectedIndexInNavigationBar = index;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
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
  List<ExerciseDatamodell> items = MyExercises().getAllExercises();

  ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          MySearchBar(
            hint: appLocalizations.searchHint, // Search
          ),
          // Display a list of dishes
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return MyMobileItem(
                  title: items[index].name,
                  onTap: (){
                    // Open an overlay showing further informations
                    OpenMyRightSheet.openMyRightSheet(context, items[index].description, items[index].task, items[index].solution, 300);
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}