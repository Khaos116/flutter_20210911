import 'package:flutter/cupertino.dart';

class ScreenUtils {
  static int width = 0;
  static int height = 0;
  static int statusHeight = 0;
  static int naviHeight = 0;

  //需要在第一个页面去初始化
  static init({required BuildContext context}) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final double ratio = MediaQuery.of(context).devicePixelRatio;
    width = (w * ratio).toInt();
    height = (h * ratio).toInt();
    statusHeight = MediaQuery.of(context).padding.top.toInt();
    naviHeight = MediaQuery.of(context).padding.bottom.toInt();
  }
}
