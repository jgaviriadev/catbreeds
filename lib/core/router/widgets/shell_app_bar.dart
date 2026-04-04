import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShellAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const ShellAppBar({
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        final isDark = themeMode == AppThemeMode.dark;
        final titleColor = isDark ? AppColors.lightBackground : AppColors.lightText;
        final switchBgColor = isDark ? Colors.grey[800] : Colors.grey[200];
        final dividerColor = isDark ? Colors.grey[600] : Colors.grey[400];

        return AppBar(
          title: Text(
            currentIndex == 0 
                ? LocaleKeys.navigationBar_first_option.tr() 
                : LocaleKeys.navigationBar_second_option.tr(),
            style: AppTextStyles.textBlackStyleBold20.copyWith(color: titleColor),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: switchBgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.light_mode, size: 20),
                      onPressed: () {
                        context.read<AppBloc>().setThemeMode(AppThemeMode.light);
                      },
                      color: Colors.orange,
                      padding: const EdgeInsets.all(8),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: dividerColor,
                    ),
                    IconButton(
                      icon: const Icon(Icons.dark_mode, size: 20),
                      onPressed: () {
                        context.read<AppBloc>().setThemeMode(AppThemeMode.dark);
                      },
                      color: Colors.grey[700],
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
