import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import '../api/api_constants.dart';
import '../util/data_utils.dart';

import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool loading = true;
  int count = 0;
  static const int MAX_COUNT = 5;

  //url变化监听器
  StreamSubscription<String> _onUrlChanged;

  //插件提供的对象，该对象用域webview的各种操作
  FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((url) {
      setState(() {
        loading = false;
      });
      //"http://yubo725.top/osc/osc.php?code="
      if (url != null && url.length > 0 && url.contains("osc/osc.php?code=")) {
        new Timer(Duration(seconds: 1), pareResult);
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onUrlChanged.cancel();

    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  //解析webview中的数据
  pareResult() {
    if (count > MAX_COUNT) {
      return;
    }

    //执行webView中的js
    flutterWebviewPlugin.evalJavascript("get();").then((result) {
      ++count;

      if (result != null && result.length > 0) {
        //"{\"access_token\":\"616255f1-37ce-4229-a512-8a2a46e1215c\",\"refresh_token\":\"0adb0b05-db51-4d01-939c-9771035ad2b1\",\"uid\":4049886,\"token_type\":\"bearer\",\"expires_in\":242028}"
        print("result = $result");
        try {
          var map = json.decode(result);
          //{"access_token":"616255f1-37ce-4229-a512-8a2a46e1215c","refresh_token":"0adb0b05-db51-4d01-939c-9771035ad2b1","uid":4049886,"token_type":"bearer","expires_in":242028}
          print("map1 = $map");
          if (map is String) {
            map = json.decode(map);
            //{access_token: 616255f1-37ce-4229-a512-8a2a46e1215c, refresh_token: 0adb0b05-db51-4d01-939c-9771035ad2b1, uid: 4049886, token_type: bearer, expires_in: 242028}
            print("map2 = $map");
          }
          if (map != null) {
            //登入成功了，保存token等信息
            DataUtils.saveLoginInfo(map);
            //弹出当前路由
            Navigator.pop(context, 'refresh');
          }
        } catch (e) {
          print(e);
        }
      } else {
        new Timer(Duration(seconds: 1), pareResult);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //添加appbar的title内容
    List<Widget> titleContent = [];
    titleContent.add(Text(
      "登入开源中国",
      style: TextStyle(color: Colors.white),
    ));
    if (loading) {
      titleContent.add(CupertinoActivityIndicator());
    }
    titleContent.add(Container(
      width: 50.0,
    ));

    //渲染一个WebView
    return new WebviewScaffold(
      url: Constants.LOGIN_URL,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //允许网页缩放
      withZoom: true,
      //允许LocalStorage
      withLocalStorage: true,
      //允许执行js
      withJavascript: true,
    );
  }
}
