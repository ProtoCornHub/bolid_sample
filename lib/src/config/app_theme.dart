import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
       centerTitle: false,
       titleTextStyle: TextStyle(
         color: Colors.black,
         fontSize: 20,
       ),
      ),
    );
  }
}
