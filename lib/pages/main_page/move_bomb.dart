/// 动弹界面
import 'package:flutter/material.dart';
import 'package:flutter_app/configs/colors_config.dart';
import 'package:flutter_app/configs/string_config.dart';

class MoveBomb extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MoveBombState();
  }
}

class MoveBombState extends State<MoveBomb> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(StringConstants.MOVE_BOMB_LOGIN_INFO),
          RaisedButton(
            onPressed: () {},
            child: Text(
              StringConstants.LOGIN, style: TextStyle(color: Colors.white)
            ),
            color: ColorConfig.primaryColor,
          )
        ],
      ),
    );
  }

}