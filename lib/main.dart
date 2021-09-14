import 'package:flutter/material.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/utils/bar_utils.dart';
import 'package:mmkv/mmkv.dart';

import 'base/base_over_page.dart';
import 'login/splash_page.dart';
import 'main.reflectable.dart' show initializeReflectable;

void main() async {
  await MMKV.initialize();
  initializeReflectable();
  runApp(const MyApp());
  BarUtils.setBarColors();
}

class MyApp extends BaseWidgetStateful {
  const MyApp({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _MyApp();
}

class _MyApp extends BaseStatefulState {
  @override
  Widget initPage(BuildContext context) {
    String _overText = '这是整个APP的悬浮';
    return OverPage(
        child: Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        MaterialApp(
            title: 'Flutter2021',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
            //默认打开闪屏页
            home: const SplashPage()),
//          //路由打开其他页面
//          routes: <String, WidgetBuilder>{
//            '/HomePage': (BuildContext context) {
//              HomePage();
//            },
//            '/GuidePage': (BuildContext context) {
//              GuidePage();
//            },
//          },
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 9.0,
                child: Text(
                  _overText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 1.0,
                        color: Colors.cyanAccent,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    ));
  }
}
