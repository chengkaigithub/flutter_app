import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

enterCommonWeb(title, url) =>
  MaterialPageRoute(
    builder: (context) {
      return CommonWebPage(
        title: title,
        url: url,
      );
    },
  );

class CommonWebPage extends StatefulWidget {
  final String title;
  final String url;

  CommonWebPage({this.title, this.url});

  @override
  State<StatefulWidget> createState() {
    return CommonWebPageState();
  }
}

class CommonWebPageState extends State<CommonWebPage> {
  bool loading = true;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    // 监听WebView的加载事件
    flutterWebviewPlugin.onUrlChanged.listen((url) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //添加appbar的title内容
    List<Widget> titleContent = [];
    titleContent.add(new Text(
      widget.title,
      style: new TextStyle(color: Colors.white),
    ));
    if (loading) {
      // 如果还在加载中，就在标题栏上显示一个圆形进度条
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));

    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
