import 'package:flutter/material.dart';

import 'home_screen.dart';

class BottomNavigatorMoneyMap extends StatelessWidget {
  const BottomNavigatorMoneyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedBottomNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(246, 116, 163, 118),
          selectedFontSize: 14,
          selectedIconTheme: const IconThemeData(size: 28),
          currentIndex: updatedIndex,
          onTap: ((indexofselected) {
            HomeScreen.selectedBottomNotifier.value = indexofselected;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_outlined),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        );
      },
    );
  }
}
