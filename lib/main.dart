import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/pages/main_page/drawer_page/drawer_page.dart';
import 'configs/colors_config.dart';
import 'pages/main_page/main_pages.dart';
import 'configs/tabbar_config.dart';
import 'pages/routers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源China',
      theme: ThemeData(
        primaryColor: ColorConfig.primaryColor
      ),
      home: Home(),
      routes: routers,
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentTabIndex = 1;
  String _currentTitle = StringConstants.NEWS;

  final _bodys = <Widget>[NewsPage(), MoveBomb(), DescoverPage(), MyPage()];

  onTabbarClick(currentIndex, currentTitle) {
    setState(() {
      this._currentTabIndex = currentIndex;
      this._currentTitle = currentTitle;
    });
  }

  renderAppBar() {
    if (_currentTabIndex == 3) {
      return null;
    } else {
      return AppBar(
        title: Text(_currentTitle),
        centerTitle: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      drawer: DrawerPage(),
      bottomNavigationBar: bottomNavigationBars(
        currentTabIndex: _currentTabIndex,
        onTabbarClick: onTabbarClick
      ),
      body: IndexedStack(
        children: _bodys,
        index: _currentTabIndex,
      )
    );
  }
}
