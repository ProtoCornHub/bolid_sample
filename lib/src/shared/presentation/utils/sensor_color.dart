import 'package:flutter/material.dart';

class SensorColor {
  static Color getColor(int status) {
    if (status == 0 || status == 6) {
      return Colors.grey;
    } else if (status == 1 || status == 5) {
      return Colors.green;
    } else if (status == 2 || status == 3) {
      return Colors.red;
    } else if (status == 4 || status == 7 || status == 8 || status == 9) {
      return Colors.yellow;
    }
    return Colors.grey;
  }
}