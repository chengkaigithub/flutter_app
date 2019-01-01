import 'dart:convert';

/// 我的界面
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/api_constants.dart';
import 'package:flutter_app/configs/colors_config.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/events/login_event.dart';
import 'package:flutter_app/events/logout_event.dart';
import 'package:flutter_app/model/user_info.dart';
import 'package:flutter_app/pages/common_page/CommonWebPage.dart';
import 'package:flutter_app/pages/routers.dart';
import 'package:flutter_app/util/data_utils.dart';
import 'package:flutter_app/util/net_utils.dart';
import 'package:flutter_app/pages/main_page/widgets/page_item.dart';

class MyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<MyPage> {

  //头像
  var userAvatar;

  //名称
  static String _userName;

  //初始化事件监听
  @override
  void initState() {
    super.initState();
    Constants.eventBus.on<LogoutEvent>().listen((event) {
      //收到退出登录的消息，刷新个人信息显示
      _showUserInfo();
    });

    Constants.eventBus.on<LoginEvent>().listen((event) {
      // 收到登录的消息，重新获取个人信息
      netGetUserInfo();
    });
  }


  GestureDetector _headerWidget() =>
    GestureDetector(
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          color: ColorConfig.primaryColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/ic_avatar_default.png', width: 60.0, height: 60.0),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                _userName ?? StringConstants.CLICK_HEADER_LOGIN,
                style: TextStyle(color: Colors.white, fontSize: 15.0)
              ),
            )
          ],
        ),
      ),
      onTap: () => _handleListItemClick(StringConstants.EMPTY),
    );

  //获取用户信息,并保存
  netGetUserInfo() async {
    String accessToken = await DataUtils.getAccessToken();
    Map<String, String> params = new Map();
    params['access_token'] = accessToken;
    NetUtils.get(Api.USER_INFO, params: params).then((data) {
      if (data != null) {
        var map = json.decode(data);
        setState(() {
          userAvatar = map['avatar'];
          _userName = map['name'];
        });
        DataUtils.saveUserInfo(map);
      }
    });
  }

  //显示用户的信息
  _showUserInfo() {
    DataUtils.getUserInfo().then((UserInfo userInfo) {
      if (userInfo != null) {
        print(userInfo.name);
        print(userInfo.avatar);
        setState(() {
          userAvatar = userInfo.avatar;
          _userName = userInfo.name;
        });
      } else {
        setState(() {
          userAvatar = null;
          _userName = null;
        });
      }
    });
  }

  _login() async {
    final result = await Navigator.pushNamed(context, Routers.LOGIN_PAGE);
    if (result != null && result == 'refresh') {
      //刷新界面
      Constants.eventBus.fire(LoginEvent());
    }
  }

  _handleListItemClick(String title) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        //未登入
        _showLoginDialog();
      } else {
        DataUtils.getUserInfo().then((info) {
          Navigator.push(context,
            enterCommonWeb(title, 'https://my.oschina.net/u/${info.id}'));
        });
      }
    });
  }

  _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringConstants.TIPS),
          content: Text(StringConstants.NOT_LOGIN_HINT),
          actions: <Widget>[
            FlatButton(
              child: Text(
                StringConstants.CANCEL, style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(
                StringConstants.CONFIRM, style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
                _login();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _headerWidget(),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_message.png'),
          StringConstants.MY_MESSAGE,
            () => _handleListItemClick(StringConstants.MY_MESSAGE)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_blog.png'),
          StringConstants.READ_RECORD,
            () => _handleListItemClick(StringConstants.READ_RECORD)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_blog.png'),
          StringConstants.MY_BLOG,
            () => _handleListItemClick(StringConstants.MY_BLOG)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_question.png'),
          StringConstants.MY_QUESTION,
            () => _handleListItemClick(StringConstants.MY_QUESTION)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_pos.png'),
          StringConstants.MY_DISCOVER_POS,
            () => _handleListItemClick(StringConstants.MY_DISCOVER_POS)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_team.png'),
          StringConstants.MY_TEAM,
            () => _handleListItemClick(StringConstants.MY_TEAM)),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_recommend.png'),
          StringConstants.MY_RECOMMEND,
            () => _handleListItemClick(StringConstants.MY_RECOMMEND)),
        PageItem.lineFull,
      ]
    );
  }

}