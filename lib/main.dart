import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/pages/main_page/components/descover_page_item.dart';
import 'configs/colors_config.dart';
import './pages/main_page/main_pages.dart';
import 'configs/tabbar_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源China',
      theme: ThemeData(
//        primarySwatch: Colors.red,
        primaryColor: ColorConfig.primaryColor
      ),
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {

  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentTabIndex = 0;

  final _bodys = [NewsPage(), MoveBomb(), DescoverPage(), MyPage()];

  onTabbarClick(currentIndex) {
    setState(() {
      this._currentTabIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: Container(
        width: 270.0,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: ListView(
          padding: EdgeInsets.only(),
          children: <Widget>[
            Image.asset('images/cover_img.jpg', width: 270.0, height: 270.0,),
            PageItem(
              PageItem.getImageAsset('images/leftmenu/ic_fabu.png'),
              StringConstants.SEND_MOVE_BOMB,
                () => print('发布动弹')
            ),
            PageItem.lineFull,
            PageItem(
              PageItem.getImageAsset('images/leftmenu/ic_xiaoheiwu.png'),
              StringConstants.MOVE_BOMB_BLACK_HOUSE,
                () => print('东单小黑屋')
            ),
            PageItem.lineFull,
            PageItem(
              PageItem.getImageAsset('images/leftmenu/ic_about.png'),
              StringConstants.ABOUT,
                () => print('关于')
            ),
            PageItem.lineFull,
            PageItem(
              PageItem.getImageAsset('images/leftmenu/ic_settings.png'),
              StringConstants.SETTING,
                () => print('设置')
            ),
            PageItem.lineFull,
          ],
        )
      ),
      bottomNavigationBar: bottomNavigationBars(
        currentTabIndex: _currentTabIndex,
        onTabbarClick: onTabbarClick
      ),
      body: _bodys[_currentTabIndex],
    );
  }
}
