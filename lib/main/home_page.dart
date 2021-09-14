import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/main/discover_page.dart';
import 'package:flutter_20210911/main/first_page.dart';
import 'package:flutter_20210911/main/my_page.dart';

//主页
class HomePage extends BaseWidgetStateful {
  const HomePage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _HomePage();
}

class _HomePage extends BaseStatefulState with SingleTickerProviderStateMixin {
  //Tab页的控制器，可以用来定义Tab标签和内容页的坐标
  TabController? _tabController;

  @override
  void enterPage() {
    super.enterPage();
    _tabController = TabController(
        length: 3, //Tab页的个数
        vsync: this //动画效果的异步处理，默认格式
        );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  void exitPage() {
    super.exitPage();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget initPage(BuildContext context) {
    //底部导航高度
    double _naviHeight = 47.5;
    //分割线高度
    double _naviLineHeight = 0.5;
    //导航文字大小
    double _naviTextSize = 18;
    //内容布局和Navigation
    return Scaffold(
      //白色背景
      backgroundColor: Colors.white,
      //上面内容的布局
      body: TabBarView(
        //禁止手动滚动
        physics: const NeverScrollableScrollPhysics(),
        //滚动同步
        controller: _tabController,
        //子页面
        children: const <Widget>[
          FirstPage(),
          DiscoverPage(),
          MyPage(),
        ],
      ),
      //底部导航
      bottomNavigationBar: SizedBox(
        height: _naviHeight + _naviLineHeight,
        //设置底部高度
        child: Column(children: <Widget>[
          //分割线
          Container(
            color: Colors.red,
            height: _naviLineHeight,
          ),
          //底部tab
          TabBar(
            //设置为没有底部下划线
            indicatorWeight: 0.00000000001,
            //滚动同步
            controller: _tabController,
            //多个tab
            tabs: <Widget>[
              SizedBox(
                height: _naviHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "首页",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: _naviTextSize,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _naviHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "发现",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: _naviTextSize,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _naviHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "我的",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: _naviTextSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
