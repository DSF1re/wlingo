import 'package:flutter/material.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: navBarItems(context));
  }
}

List<BottomNavigationBarItem> navBarItems(BuildContext context) => [
  BottomNavigationBarItem(
    icon: const Icon(Icons.home_outlined),
    activeIcon: const Icon(Icons.home),
    label: AppLocalizations.of(context)!.home,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu_book_outlined),
    activeIcon: Icon(Icons.menu_book),
    label: AppLocalizations.of(context)!.materials,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: AppLocalizations.of(context)!.profile,
  ),
];
