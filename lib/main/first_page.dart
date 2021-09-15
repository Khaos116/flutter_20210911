import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_20210911/base/base_state_page.dart';
import 'package:flutter_20210911/bean/time_bean.dart';
import 'package:flutter_20210911/utils/regexp_utils.dart';
import 'package:flutter_20210911/utils/time_utils.dart';
import 'package:flutter_20210911/utils/toast_utils.dart';

//首页
class FirstPage extends BaseWidgetStateful {
  const FirstPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseWidgetStateful> createState() => _FirstPage();
}

class _FirstPage extends BaseStatefulState {
  //焦点处理
  final FocusNode _focusNode = FocusNode();

  //监听输入
  final TextEditingController _controller = TextEditingController();

  //响应结果
  String _response = '';

  void _handleControllerChanged() {
    setState(() {});
  }

  @override
  void enterPage() {
    super.enterPage();
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void exitPage() {
    super.exitPage();
    _controller.removeListener(_handleControllerChanged);
  }

  @override
  Widget initPage(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.verified_user,
                        size: 30,
                        color: Colors.cyan.shade200,
                      )),
                  Expanded(
                      child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 35.0),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      inputFormatters: [
                        //长度限制限制
                        LengthLimitingTextInputFormatter(150),
                        //限制单行
                        FilteringTextInputFormatter.singleLineFormatter,
                        //只能输入数字
                        //FilteringTextInputFormatter.digitsOnly,
                        //自定义输入限制
                        IgnoreOtherFormatter(),
                      ],
                      style: const TextStyle(fontSize: 14.0),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: OutlineInputBorder(),
                        hintText: '请输入用户名',
                        filled: true,
                        fillColor: Color(0xffF5F5F5),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: _controller.text.trim().isEmpty ? Colors.transparent : Colors.blue.shade100,
                    child: Text(
                      _controller.text.trim().isEmpty ? '这里会同步显示输入内容' : _controller.text.trim(),
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500, color: _controller.text.trim().isEmpty ? Colors.grey.shade300 : Colors.red.shade600),
                    ))),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.pinkAccent.shade100,
                child: const Text(
                  '点击这里测试吐司输入内容',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () => {_focusNode.unfocus(), ToastUtils.showToast(msg: _controller.text.trim())},
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: _response.trim().isEmpty ? Colors.transparent : Colors.blue.shade100,
                    child: Text(
                      _response.isEmpty ? '这里会显示接口响应内容' : _response.trim(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: _response.trim().isEmpty ? Colors.grey.shade300 : Colors.green.shade600),
                    ))),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.pinkAccent.shade100,
                child: const Text(
                  '点击这里获取服务器时间',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () => {_focusNode.unfocus(), getServerTime()},
            ),
          ],
        ),
      ),
    );
  }

  void getServerTime() async {
    try {
      var response = await Dio().get('http://vv.video.qq.com/checktime?otype=json');
      if (response.statusCode == 200) {
        //QZOutputJson={'s':'o','t':1631339067,'ip':'103.109.71.37','pos':'---','rand':'7jBwIVnTkm27cPIMHeY2dw=='};
        String temp = response.toString();
        try {
          _response = temp.substring(temp.indexOf('{'), temp.lastIndexOf('}') + 1);
          // var map = json.decode(_response);
          var bean = JsonMapper.deserialize<TimeBean>(_response);
          if (bean == null) {
            _response = 'Json解析异常';
          } else {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(bean.time * 1000);
            _response = '时间：${TimeUtils.formatDateMy(date: date)}\nIP：${bean.ip}';
          }
        } catch (e) {
          print(e);
          _response = e.toString();
        }
      } else {
        _response = response.statusMessage.toString();
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
