import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movies_app/pages/home.dart';
import 'package:movies_app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = Platform.localeName;
    initializeDateFormatting();

    return MaterialApp(
      title: "Movies App",
      initialRoute: Home.ROUTE,
      routes: routes,
    );
  }
}