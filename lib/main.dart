import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page/DrawerPage.dart';
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
      drawer: DrawerPage(),
      bottomNavigationBar: bottomNavigationBars(
        currentTabIndex: _currentTabIndex,
        onTabbarClick: onTabbarClick
      ),
      body: _bodys[_currentTabIndex],
    );
  }
}
