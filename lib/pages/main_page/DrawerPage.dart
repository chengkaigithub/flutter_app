import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/pages/main_page/components/descover_page_item.dart';

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
    );
  }

}