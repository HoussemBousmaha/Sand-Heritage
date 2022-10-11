import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/size_manager.dart';

class OnboardingView extends HookConsumerWidget {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController(initialPage: 0);
    return Scaffold(
      body: PageView.builder(
        itemCount: AssetsManager.onboardingList.length,
        controller: controller,
        itemBuilder: (context, index) {
          return OnboardingSliderView(
            controller: controller,
            path: AssetsManager.onboardingList[index],
            title: 'Travel Anywhere in Saudi Arabia\nWithout any hussle',
            subtitle: 'are you looking to travel to saudi arabia?\nthis is your place',
            isLast: index == AssetsManager.onboardingList.length - 1,
          );
        },
      ),
    );
  }
}

class OnboardingSliderView extends HookConsumerWidget {
  const OnboardingSliderView({
    Key? key,
    required this.controller,
    required this.path,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  }) : super(key: key);

  final PageController controller;
  final String path;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = TextStyle(fontSize: getHeight(context, 20), fontWeight: FontWeight.w700, height: 1.5, color: ColorManager.kTitleText);
    final subtitleStyle = TextStyle(fontSize: getHeight(context, 14), fontWeight: FontWeight.w600, height: 1.4, color: ColorManager.kSubtitleText);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(context, 591),
                width: getWidth(context, 406),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  child: Image(image: AssetImage(path), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: getHeight(context, 20)),
              Text(title, style: titleStyle, textAlign: TextAlign.center),
              SizedBox(height: getHeight(context, 20)),
              Text(subtitle, textAlign: TextAlign.center, style: subtitleStyle),
              SizedBox(height: getHeight(context, 25)),
              isLast ? _getStartButton(context) : _getSkipOrNextRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _getSkipOrNextRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: getHeight(context, 50),
          width: getWidth(context, 120),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.kPrimary),
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
              backgroundColor: ColorManager.kWhite,
              foregroundColor: ColorManager.kPrimary,
            ),
            onPressed: () => Navigator.of(context).pushNamed(Routes.homeRoute),
            child: const Text(
              'Skip',
              style: TextStyle(color: ColorManager.kSubtitleText),
            ),
          ),
        ),
        SizedBox(width: getWidth(context, 20)),
        Container(
          height: getHeight(context, 50),
          width: getWidth(context, 120),
          decoration: const BoxDecoration(
            color: ColorManager.kPrimary,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
              backgroundColor: ColorManager.kPrimary,
              foregroundColor: ColorManager.kWhite,
            ),
            onPressed: () {
              final currentPage = controller.page!.toInt();
              controller.animateToPage(currentPage + 1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Container _getStartButton(BuildContext context) {
    return Container(
      height: getHeight(context, 50),
      width: getWidth(context, 120),
      decoration: const BoxDecoration(
        color: ColorManager.kPrimary,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
          backgroundColor: ColorManager.kPrimary,
          foregroundColor: ColorManager.kWhite,
        ),
        onPressed: () => Navigator.of(context).pushNamed(Routes.homeRoute),
        child: const Text(
          'Start',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
