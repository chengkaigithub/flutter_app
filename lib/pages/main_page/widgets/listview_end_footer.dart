import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';

class ListViewEndFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
          Text(StringConstants.LISTVIEW_FOOTER_BOTTOM),
          Expanded(
            child: new Divider(height: 10.0,),
            flex: 1,
          ),
        ],
      ),
    );
  }
}