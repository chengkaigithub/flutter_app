/// 我的界面
import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import '../../configs/colors_config.dart';
import 'components/descover_page_item.dart';

class MyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<MyPage> {

  GestureDetector _headerWidget = GestureDetector(
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
              StringConstants.CLICK_HEADER_LOGIN,
              style: TextStyle(color: Colors.white, fontSize: 15.0)
            ),
          )
        ],
      ),
    ),
    onTap: () {
      print('点击头像');
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _headerWidget,
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_message.png'),
          StringConstants.MY_MESSAGE,
            () => print('点击了 我的消息')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_blog.png'),
          StringConstants.READ_RECORD,
            () => print('点击了 阅读记录')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_blog.png'),
          StringConstants.MY_BLOG,
            () => print('点击了 我的博客')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_question.png'),
          StringConstants.MY_QUESTION,
            () => print('点击了 我的问答')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_pos.png'),
          StringConstants.MY_DISCOVER_POS,
            () => print('点击了 我的活动')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_team.png'),
          StringConstants.MY_TEAM,
            () => print('点击了 我的团队')),
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_my_recommend.png'),
          StringConstants.MY_RECOMMEND,
            () => print('点击了 邀请好友')),
        PageItem.lineFull,
      ]
    );
  }

}