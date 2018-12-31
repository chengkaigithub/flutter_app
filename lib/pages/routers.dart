import 'package:flutter/material.dart';
import 'package:flutter_app/pages/LoginPage.dart';
import 'package:flutter_app/pages/main_page/drawer_page/about_page.dart';
import 'package:flutter_app/pages/main_page/drawer_page/dark_house.dart';
import 'package:flutter_app/pages/main_page/drawer_page/bomb.dart';
import 'package:flutter_app/pages/main_page/drawer_page/setting_page.dart';
import 'package:flutter_app/pages/main_page/publish_tweet_page.dart';


class Routers {
  static const SETTING_PAGE = '/SettingPage';
  static const DARKHOUSE_PAGE = '/DarkHousePage';
  static const ABOUT_PAGE = '/AboutPage';
  static const BOMB_PAGE = '/BombPage';
  static const LOGIN_PAGE = '/LoginPage';
  static const PUBLISH_TWEET_PAGE = '/PublishTweetPage';
}

final Map<String, WidgetBuilder> routers = {
  Routers.SETTING_PAGE: (context) => SettingPage(),
  Routers.DARKHOUSE_PAGE: (context) => DarkHousePage(),
  Routers.ABOUT_PAGE: (context) => AboutPage(),
  Routers.LOGIN_PAGE: (context) => LoginPage(),
  Routers.BOMB_PAGE: (context) => BombPage(),
  Routers.PUBLISH_TWEET_PAGE: (context) => PublishTweetPage(),
};


