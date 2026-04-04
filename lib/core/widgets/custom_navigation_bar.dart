import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Navigation tabs available in the bottom navigation bar
enum NavigationTab { breeds, favorites }

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    required this.currentIndex,
    required this.onTabChanged,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<NavigationTab> onTabChanged;

  static const EdgeInsets iconPadding = EdgeInsets.only(bottom: 2, top: 4);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) {
        final tab = NavigationTab.values[index];
        onTabChanged(tab);
      },
      items: [
        BottomNavigationBarItem(
          icon: const Padding(
            padding: iconPadding,
            child: FaIcon(
              FontAwesomeIcons.cat,
              size: 20,
            ),
          ),
          activeIcon: const Padding(
            padding: iconPadding,
            child: FaIcon(FontAwesomeIcons.cat),
          ),
          label: LocaleKeys.navigationBar_first_option.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Padding(
            padding: iconPadding,
            child: FaIcon(
              FontAwesomeIcons.heart,
              size: 20,
            ),
          ),
          activeIcon: const Padding(
            padding: iconPadding,
            child: FaIcon(FontAwesomeIcons.heartPulse),
          ),
          label: LocaleKeys.navigationBar_second_option.tr(),
        ),
      ],
    );
  }
}
