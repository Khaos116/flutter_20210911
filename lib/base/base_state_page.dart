import 'package:flutter/material.dart';
import 'package:flutter_20210911/utils/anim_utils.dart';

///基类 widget(无状态Widget，就是说一旦这个Widget创建完成，状态就不允许再变动)
abstract class BaseWidgetStateless extends StatelessWidget {
  ///构造函数
  const BaseWidgetStateless({Key? key}) : super(key: key);

  ///build
  @override
  Widget build(BuildContext context) {
    return initDefaultBuild(context);
  }

  ///界面构建
  Widget initDefaultBuild(BuildContext context);
}

///基类 widget(有状态Widget，就是说当前Widget创建完成之后，还可以对当前Widget做更改，可以通过setState函数来刷新当前Widget来达到有状态)
abstract class BaseWidgetStateful extends StatefulWidget {
  ///构造函数
  const BaseWidgetStateful({Key? key}) : super(key: key);
}

///基础 state
abstract class BaseStatefulState<T extends BaseWidgetStateful> extends State<T> {
  ///initState
  @override
  void initState() {
    enterPage();
    super.initState();
  }

  ///dispose
  @override
  void dispose() {
    super.dispose();
    exitPage();
  }

  ///build
  @override
  Widget build(BuildContext context) {
    return initPage(context);
  }

  //界面进入
  void enterPage() {}

  //界面销毁
  void exitPage() {}

  ///界面构建
  Widget initPage(BuildContext context);

  //打开其他页面
  void go2OtherPage({required Widget widget, bool anim = true}) {
    Navigator.push(context, anim ? Right2LeftRouter(child: widget) : NoAnimRouter(widget));
  }

  //打开其他页面并关闭自己
  void go2PageFinishSelf({required Widget widget, bool anim = true}) {
    Navigator.pushReplacement(context, anim ? Right2LeftRouter(child: widget) : NoAnimRouter(widget));
  }
}
// push 将设置的router信息推送到Navigator上，实现页面跳转。
// of 主要是获取 Navigator最近实例的好状态。
// pop 导航到新页面，或者返回到上个页面。
// canPop 判断是否可以导航到新页面
// maybePop 可能会导航到新页面
// popAndPushNamed 指定一个路由路径，并导航到新页面。
// popUntil 反复执行pop 直到该函数的参数predicate返回true为止。
// pushAndRemoveUntil 将给定路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
// pushNamed 将命名路由推送到Navigator。
// pushNamedAndRemoveUntil 将命名路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
// pushReplacement 路由替换。
// pushReplacementNamed 这个也是替换路由操作。推送一个命名路由到Navigator，新路由完成动画之后处理上一个路由。
// removeRoute 从Navigator中删除路由，同时执行Route.dispose操作。
// removeRouteBelow 从Navigator中删除路由，同时执行Route.dispose操作，要替换的路由是传入参数anchorRouter里面的路由。
// replace 将Navigator中的路由替换成一个新路由。
// replaceRouteBelow 将Navigator中的路由替换成一个新路由，要替换的路由是是传入参数anchorRouter里面的路由。
