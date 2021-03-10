import 'package:flutter/material.dart';

import 'screens/screen_one.dart';
import 'screens/screen_two.dart';

enum Screens { ScreenOne, ScreenTwo }

Map<String, Widget Function(BuildContext)> routes = {
  Screens.ScreenOne.toString(): (_) => ScreenOne(),
  Screens.ScreenTwo.toString(): (_) => ScreenTwo(),
};
