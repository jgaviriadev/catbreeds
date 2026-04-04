import 'dart:async';

import 'package:cat_breeds/app/bloc/app_bloc.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/presentation/pages/breed_page.dart';
import 'package:cat_breeds/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    context.read<AppBloc>().loadTheme();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    context.goNamed(BreedPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.splash_app_title.tr(),
              style: AppTextStyles.textWhiteStyleBold32,
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
