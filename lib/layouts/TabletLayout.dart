import 'package:code_juge/main.dart';
import 'package:code_juge/pages/settings_page.dart';
import 'package:code_juge/ui_elements/my_infomation_right_sheet.dart';
import 'package:code_juge/ui_elements/my_list_items.dart';
import 'package:code_juge/ui_elements/my_navigation_bar.dart';
import 'package:code_juge/ui_elements/my_search_bar.dart';
import 'package:code_juge/utils/global_variables.dart';
import 'package:flutter/material.dart';

class Tabletlayout extends StatefulWidget{
  @override
  State<Tabletlayout> createState() => _TabletlayoutState();
}

class _TabletlayoutState extends State<Tabletlayout> {
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
      screenType: ScreenType.tablet,
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
  // TODO Display the correct exercises
  List<String> items =  ["tt", "tttt", "ttttttt"];

  ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MySearchBar(
            // TODO Implemtent translation
            hint: "Search"
          ),
          // Display a list of dishes
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: List.generate(
                items.length,
                (index) {
                  // TODO Implement translation
                  return MyDesktopAndTabletItem(
                    title: items[index],
                    onTap: (){
                      // Open overlay showing further informations
                      OpenMyRightSheet.openMyRightSheet(context, "blablabla", 500);
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