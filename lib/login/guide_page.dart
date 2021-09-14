import 'package:flutter/material.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/constant/string_constants.dart';
import 'package:flutter_20210911/login/login_page.dart';
import 'package:flutter_20210911/main/home_page.dart';
import 'package:flutter_20210911/widget/no_over_behavior.dart';
import 'package:mmkv/mmkv.dart';

class GuidePage extends BaseWidgetStateful {
  const GuidePage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _GuidePage();
}

class _GuidePage extends BaseStatefulState with SingleTickerProviderStateMixin {
  TabController? _controller;

  List<String> imsGuides = [
    'images/guide1.png',
    'images/guide2.png',
    'images/guide3.png',
    'images/guide4.png',
  ];

  //打开新的页面
  void go2NextPage() async {
    var mmkv = MMKV.defaultMMKV();
    mmkv.encodeBool(StringConstants.keyFirstOpenApp, false);
    bool hasLogin = mmkv.decodeBool(StringConstants.keyHasLogin);
    go2PageFinishSelf(widget: hasLogin ? const HomePage() : const LoginPage());
  }

  @override
  void enterPage() {
    super.enterPage();
    _controller = TabController(length: imsGuides.length, vsync: this);
  }

  @override
  void exitPage() {
    super.exitPage();
    _controller = null;
  }

  @override
  Widget initPage(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(color: Colors.white),
      ScrollConfiguration(
        behavior: NoOverBehavior(),
        child: TabBarView(
          controller: _controller,
          children: imsGuides
              .map((url) => Stack(fit: StackFit.expand, children: <Widget>[
                    Image.asset(url, fit: BoxFit.fitWidth),
                    url == imsGuides[imsGuides.length - 1]
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                child: OutlinedButton(
                                  // 文本内容
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      '立即体验',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: const BorderSide(color: Colors.pinkAccent, width: 2),
                                    shape: const RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(100))),
                                  ),
                                  // OutlineButton 的点击事件
                                  onPressed: () {
                                    go2NextPage();
                                  },
                                )),
                          )
                        : const Align(),
                  ]))
              .toList(),
        ),
      ),
      Positioned(
        bottom: 8,
        child: TabPageSelector(
          controller: _controller,
          color: Colors.lightBlueAccent,
          selectedColor: Colors.pinkAccent,
          indicatorSize: 10.0,
        ),
      )
    ]);
  }
}
