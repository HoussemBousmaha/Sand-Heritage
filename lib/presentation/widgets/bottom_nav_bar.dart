import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/assets_manager.dart';
import '../resources/size_manager.dart';
import 'experience_button.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key, required this.selectedIndexNotifier}) : super(key: key);

  final ValueNotifier<int> selectedIndexNotifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getHeight(context, 30),
      child: CustomPaint(
        painter: BottomPainter(),
        size: Size(getWidth(context, 385), getHeight(context, 65)),
        child: SizedBox(
          height: getHeight(context, 65),
          width: getWidth(context, 385),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: getWidth(context, 150),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => selectedIndexNotifier.value = 0,
                          child: SvgPicture.asset(
                            AssetsManager.iconsList[0],
                            color: selectedIndexNotifier.value == 0 ? ColorManager.kPrimary : ColorManager.kSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => selectedIndexNotifier.value = 1,
                          child: SvgPicture.asset(
                            AssetsManager.iconsList[1],
                            color: selectedIndexNotifier.value == 1 ? ColorManager.kPrimary : ColorManager.kSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: getWidth(context, 150),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => selectedIndexNotifier.value = 2,
                          child: SvgPicture.asset(
                            AssetsManager.iconsList[2],
                            color: selectedIndexNotifier.value == 2 ? ColorManager.kPrimary : ColorManager.kSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => selectedIndexNotifier.value = 3,
                          child: SvgPicture.asset(
                            AssetsManager.iconsList[3],
                            color: selectedIndexNotifier.value == 3 ? ColorManager.kPrimary : ColorManager.kSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const ExperienceButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.kPrimary.withOpacity(.4)
      ..style = PaintingStyle.fill;

    final path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 0, size.width * .1, 0);
    path.lineTo(size.width * .35, 0);
    path.quadraticBezierTo(size.width * .4, 0, size.width * .4, 20);
    path.arcToPoint(Offset(size.width * .6, 20), radius: const Radius.circular(20), clockwise: false);
    path.quadraticBezierTo(size.width * .6, 0, size.width * .65, 0);
    path.lineTo(size.width * .9, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(size.width, size.height, size.width * .9, size.height);
    path.lineTo(size.width * .1, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
