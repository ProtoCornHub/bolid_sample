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

  static String getValue(int status) {
    if (status == 0) {
      return 'Неизвестно';
    } else if (status == 1) {
      return 'Готов';
    } else if (status == 2) {
      return 'Тревога';
    } else if (status == 3) {
      return 'Пожар';
    } else if (status == 4) {
      return 'Корпус открыт';
    } else if (status == 5) {
      return 'Корпус закрыт';
    } else if (status == 6) {
      return 'Потерян';
    } else if (status == 7) {
      return 'Низкий заряд батареи';
    } else if (status == 8) {
      return 'Событие по температуре';
    } else if (status == 8) {
      return 'Событие по влажности';
    }
    return 'Исключение';
  }
}