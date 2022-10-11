import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/size_manager.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Timer(const Duration(seconds: 1), () => Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute));
      return null;
    });

    return Scaffold(
      backgroundColor: ColorManager.kPrimary,
      body: Center(
        child: SvgPicture.asset(
          AssetsManager.logo,
          color: ColorManager.kWhite,
          height: getHeight(context, 150),
        ),
      ),
    );
  }
}
