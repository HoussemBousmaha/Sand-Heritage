import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../home_view/home_view.dart';
import '../map_view/map_view.dart';

class Wrapper extends HookConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  static const views = [HomeView(), MapView(), Scaffold(), Scaffold()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndexNotifier = useState<int>(0);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          views[selectedIndexNotifier.value],
          BottomNav(selectedIndexNotifier: selectedIndexNotifier),
        ],
      ),
    );
  }
}
