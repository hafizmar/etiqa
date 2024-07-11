import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant.dart';

final appBarTheme = const AppBarTheme(
  centerTitle: false,
  elevation: 0,
  backgroundColor: kPrimary,
);

final tabBarTheme = const TabBarTheme(
    indicator: BoxDecoration(
  color: Colors.transparent,
));

final dividerTheme =
    const DividerThemeData().copyWith(thickness: 0.0, indent: 15.0);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: kPrimary,
      scaffoldBackgroundColor: kScaffold,
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme,
      dividerTheme: dividerTheme.copyWith(color: kIconLight),
      iconTheme: const IconThemeData(color: kIconLight),
      textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme)
          .apply(displayColor: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.black,
    );

ThemeData darkTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: kPrimary,
      scaffoldBackgroundColor: kScaffoldDark,
      appBarTheme: appBarTheme.copyWith(backgroundColor: kAppBarDark),
      tabBarTheme: tabBarTheme,
      dividerTheme: dividerTheme.copyWith(color: kBubbleDark),
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme)
          .apply(displayColor: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white,
    );

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}
