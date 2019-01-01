import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {

  static const Divider lineFull = Divider(height: 1.0);
  static const Divider lineHalf = Divider(indent: 50, height: 1.0);
  static const Padding paddingTop = Padding(
    padding: EdgeInsets.only(top: 15.0));

  static getImageAsset(String imgPath) =>
    Image.asset(imgPath, width: 30.0, height: 30.0);

  final String _title;
  final Function _onItemClick;
  final _leftIcon;
  final isPopDrawer;

  PageItem(this._leftIcon, this._title, this._onItemClick, {isPopDrawer: false})
    : this.isPopDrawer = isPopDrawer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: _leftIcon,
            ),
            Text(_title, style: TextStyle(fontSize: 16.0),),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 25.0),
                  )
                ],
              )
            )
          ],
        ),
      ),
      highlightColor: Colors.black12,
      onTap: () {
        if (isPopDrawer) Navigator.pop(context);
        _onItemClick();
      }
    );
  }


}