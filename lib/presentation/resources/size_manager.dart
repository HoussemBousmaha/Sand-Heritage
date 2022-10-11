import 'package:flutter/material.dart';

double getHeight(BuildContext context, double height) {
  final size = MediaQuery.of(context).size;
  return size.height * height / 932;
}

double getWidth(BuildContext context, double width) {
  final size = MediaQuery.of(context).size;
  return size.width * width / 430;
}
