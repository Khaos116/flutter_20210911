import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/constant/string_constants.dart';
import 'package:flutter_20210911/main/home_page.dart';
import 'package:mmkv/mmkv.dart';

class LoginPage extends BaseWidgetStateful {
  const LoginPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _LoginPage();
}

class _LoginPage extends BaseStatefulState {
  @override
  Widget initPage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(color: Colors.white),
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
        //登录按钮
        Positioned(
          bottom: 60,
          child: GestureDetector(
              onTapUp: (details) {
                go2PageFinishSelf(widget: const HomePage());
                loginStart();
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    "images/ic_phone.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const Text('点击登录',
                    style: TextStyle(
                        color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, decoration: TextDecoration.none)),
              ])),
        ),
      ],
    );
  }

  //开始登录
  void loginStart() async {
    MMKV.defaultMMKV().encodeBool(StringConstants.keyHasLogin, true);
  }
}
