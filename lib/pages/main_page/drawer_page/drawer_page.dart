import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/pages/main_page/widgets/page_item.dart';
import 'package:flutter_app/pages/routers.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              () => Navigator.pushNamed(context, Routers.PUBLISH_TWEET_PAGE),
            isPopDrawer: true
          ),
          PageItem.lineFull,
          PageItem(
            PageItem.getImageAsset('images/leftmenu/ic_xiaoheiwu.png'),
            StringConstants.MOVE_BOMB_BLACK_HOUSE,
              () => Navigator.pushNamed(context, Routers.DARKHOUSE_PAGE),
            isPopDrawer: true
          ),
          PageItem.lineFull,
          PageItem(
            PageItem.getImageAsset('images/leftmenu/ic_about.png'),
            StringConstants.ABOUT,
              () => Navigator.pushNamed(context, Routers.ABOUT_PAGE),
            isPopDrawer: true
          ),
          PageItem.lineFull,
          PageItem(
            PageItem.getImageAsset('images/leftmenu/ic_settings.png'),
            StringConstants.SETTING,
              () => Navigator.pushNamed(context, Routers.SETTING_PAGE),
            isPopDrawer: true
          ),
          PageItem.lineFull,
        ],
      )
    );
  }

}