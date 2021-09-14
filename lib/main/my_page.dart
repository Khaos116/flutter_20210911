import 'package:flutter/material.dart';
import 'package:flutter_20210911/base/base_state_page.dart';

//我的
class MyPage extends BaseWidgetStateful {
  const MyPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _MyPagePage();
}

class _MyPagePage extends BaseStatefulState {
  @override
  Widget initPage(BuildContext context) {
    return Container(
      child: const Text(
        "我的",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
      alignment: Alignment.center,
      color: Colors.white,
    );
  }
}
