import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.ABOUT),
        centerTitle: true
      ),
      body: Container(
        child: Center(
          child: Text(StringConstants.ABOUT),
        ),
      ),
    );
  }

}