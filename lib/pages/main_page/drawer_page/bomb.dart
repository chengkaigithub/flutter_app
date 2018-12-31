import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';

class BombPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.SEND_MOVE_BOMB),
        centerTitle: true
      ),
      body: Container(
        child: Center(
          child: Text(StringConstants.SEND_MOVE_BOMB),
        ),
      ),
    );
  }

}