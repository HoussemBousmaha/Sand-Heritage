import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/size_manager.dart';

class ExperienceButton extends HookConsumerWidget {
  const ExperienceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: const Alignment(0, -4),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(Routes.experienceRoute),
        child: Container(
          height: getHeight(context, 60),
          width: getWidth(context, 60),
          decoration: const BoxDecoration(
            color: ColorManager.kPrimary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.qr_code, color: ColorManager.kWhite),
        ),
      ),
    );
  }
}
