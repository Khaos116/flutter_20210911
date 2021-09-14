import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/constant/string_constants.dart';
import 'package:flutter_20210911/main/home_page.dart';
import 'package:flutter_20210911/utils/screen_utils.dart';
import 'package:mmkv/mmkv.dart';

import 'guide_page.dart';
import 'login_page.dart';

//闪屏页
class SplashPage extends BaseWidgetStateful {
  const SplashPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _SplashPage();
}

class _SplashPage extends BaseStatefulState {
  //计时器
  Timer? _countdownTimer;

  //倒计时
  int _countdownNum = 3;

  //是否已经跳转
  bool hasGoNext = false;

  @override
  void enterPage() {
    super.enterPage();
    // SystemChrome.setEnabledSystemUIOverlays([]);
    countDown();
  }

  @override
  void exitPage() {
    super.exitPage();
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  //倒计时开始跳转
  void countDown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownNum--;
      if (_countdownNum <= 0) {
        countDownFinish();
      } else {
        setState(() {});
      }
    });
  }

  //倒计时结束
  void countDownFinish() {
    if (!hasGoNext) {
      hasGoNext = true;
      _countdownTimer?.cancel();
      var mmkv = MMKV.defaultMMKV();
      bool isFirstOpenApp = mmkv.decodeBool(StringConstants.keyFirstOpenApp, defaultValue: true);
      if (isFirstOpenApp) {
        go2GuidePage();
      } else {
        bool hasLogin = mmkv.decodeBool(StringConstants.keyHasLogin);
        if (hasLogin) {
          go2HomePage();
        } else {
          go2LoginPage();
        }
      }
    }
  }

  //打开引导页
  void go2GuidePage() {
    go2PageFinishSelf(widget: const GuidePage());
  }

  //打开登录页
  void go2LoginPage() {
    go2PageFinishSelf(widget: const LoginPage(), anim: false);
  }

  //打开主页
  void go2HomePage() {
    go2PageFinishSelf(widget: const HomePage());
  }

  @override
  Widget initPage(BuildContext context) {
    ScreenUtils.init(context: context);
    return Stack(
      children: <Widget>[
        //上面图标
        Align(
            alignment: Alignment.center,
            child: Container(
                margin: const EdgeInsets.only(bottom: 166),
                child: Image.asset(
                  "images/ic_pic_up.png",
                  fit: BoxFit.fitWidth,
                ))),
        //下面图标
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "images/ic_pic_down.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        //倒计时
        Align(
          alignment: Alignment.topRight,
          child: Container(
              width: 32.0,
              height: 32.0,
              margin: EdgeInsets.fromLTRB(0.0, ScreenUtils.statusHeight + 10.0, 15.0, 0.0),
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => {countDownFinish()},
                child: PhysicalShape(
                  clipper: const ShapeBorderClipper(shape: CircleBorder(side: BorderSide.none)),
                  color: Colors.cyanAccent.shade100,
                  child: Center(
                    child: Text(
                      "$_countdownNum",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.pinkAccent, fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, decoration: TextDecoration.none),
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
