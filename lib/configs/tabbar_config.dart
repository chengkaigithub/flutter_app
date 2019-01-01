import 'package:flutter/material.dart';
import 'string_config.dart';
import 'colors_config.dart';

const TAB_TITLES = [
  StringConstants.NEWS,
  StringConstants.MOVE_BOMB,
  StringConstants.DESCOVER,
  StringConstants.MINE
];
final tabActiveIcons = [
  Icon(Icons.description, color: ColorConfig.primaryColor),
  Icon(Icons.favorite, color: ColorConfig.primaryColor,),
  Icon(Icons.wb_iridescent, color: ColorConfig.primaryColor),
  Icon(Icons.perm_contact_calendar, color: ColorConfig.primaryColor),
//  Image.asset('images/ic_nav_news_actived.png', width: 24.0, height: 24.0),
//  Image.asset('images/ic_nav_tweet_actived.png', width: 24.0, height: 24.0),
//  Image.asset('images/ic_nav_discover_actived.png', width: 24.0, height: 24.0),
//  Image.asset('images/ic_nav_my_actived.png', width: 24.0, height: 24.0),
];
final tabIcons = [
  Icon(Icons.description, color: Colors.blueGrey),
  Icon(Icons.favorite, color: Colors.blueGrey,),
  Icon(Icons.wb_iridescent, color: Colors.blueGrey),
  Icon(Icons.perm_contact_calendar, color: Colors.blueGrey),
//  Image.asset('images/ic_nav_news_normal.png', width: 24.0, height: 24.0, color: Colors.blueGrey,),
//  Image.asset('images/ic_nav_tweet_normal.png', width: 24.0, height: 24.0, color: Colors.blueGrey,),
//  Image.asset('images/ic_nav_discover_normal.png', width: 24.0, height: 24.0, color: Colors.blueGrey,),
//  Image.asset('images/ic_nav_my_normal.png', width: 24.0, height: 24.0, color: Colors.blueGrey,),
];

emptyMethod(int index) {}

List<BottomNavigationBarItem> generateItems() {
  List<BottomNavigationBarItem> tabs = [];
  int tabsLength = (
    TAB_TITLES.length <= tabIcons.length ? TAB_TITLES
      .length : tabIcons.length
  );
  for (int i = 0; i < tabsLength; i++) {
    tabs.add(generateItem(TAB_TITLES[i], tabIcons[i], tabActiveIcons[i]));
  }
  return tabs;
}

BottomNavigationBarItem generateItem(String title, iconData, activeIconData) {
  return BottomNavigationBarItem(
    icon: iconData,
    activeIcon: activeIconData,
    title: Padding(
      padding: EdgeInsets.only(top: 1.0),
      child: Text(
        title,
        style: TextStyle(color: ColorConfig.primaryColor, fontSize: 12.0)),
    ),
  );
}

Widget bottomNavigationBars(
  {int currentTabIndex = 0, Function onTabbarClick = emptyMethod}) {
  return BottomNavigationBar(
    currentIndex: currentTabIndex,
    type: BottomNavigationBarType.shifting,
    items: generateItems(),
    onTap: (index) => onTabbarClick(index, TAB_TITLES[index]),
  );
}