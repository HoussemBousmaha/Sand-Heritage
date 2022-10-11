import 'package:flutter/material.dart';

import '../presentation/resources/routes_manager.dart';

class SandCultureApp extends StatelessWidget {
  const SandCultureApp._internal();

  factory SandCultureApp() => const SandCultureApp._internal();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TextRecognitionView(),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
