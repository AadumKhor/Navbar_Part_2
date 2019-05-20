import 'package:flutter/material.dart';

class RelativeSize{
  static double getSize(double value){
    return value * (kBottomNavigationBarHeight/56);
  }
}