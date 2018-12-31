import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';

class DarkHousePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.MOVE_BOMB_BLACK_HOUSE),
        centerTitle: true
      ),
      body: Container(
        child: Center(
          child: Text(StringConstants.MOVE_BOMB_BLACK_HOUSE),
        ),
      ),
    );
  }

}