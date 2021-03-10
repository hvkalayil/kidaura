import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidaura/business_logic/country_bloc.dart';
import 'package:kidaura/data/services.dart';

import 'presentation/routes.dart';

void main() {
  runApp(KidAuraApp());
}

class KidAuraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryBloc(CountryServices()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KidAura',
        routes: routes,
        initialRoute: Screens.ScreenOne.toString(),
      ),
    );
  }
}
