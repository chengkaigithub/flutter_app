import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:flutter_app/pages/main_page/components/page_item.dart';

class SettingPage extends StatelessWidget {

  _switchTheme() {

  }

  _loginOut() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.SETTING),
        centerTitle: true
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            PageItem.paddingTop,
            PageItem.lineFull,
            PageItem(
              PageItem.getImageAsset('images/ic_discover_nearby.png'),
              StringConstants.SWITCH_THEME,
              _switchTheme),
            PageItem.lineFull,
            PageItem(
              PageItem.getImageAsset('images/ic_discover_nearby.png'),
              StringConstants.LOGIN_OUT,
              _loginOut),
            PageItem.lineFull,
          ],
        ),
      ),
    );
  }

}