import 'package:flutter/material.dart';

class NewsItemView extends StatefulWidget {
  final data;

  NewsItemView(this.data);

  @override
  State<StatefulWidget> createState() {
    return NewsItemViewState(data);
  }
}

class NewsItemViewState extends State<NewsItemView> {
  var itemData;

  TextStyle subTitleStyle = TextStyle(color: Color(0xFFB5BDC0), fontSize: 12.0);

  NewsItemViewState(this.itemData);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  itemData['title'],
                  style: TextStyle(fontSize: 15.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: timeRow(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            width: 100.0,
            height: 80.0,
            color: Color(0xffececec),
            child: Center(
              child: thumbImg(),
            ),
          ),
        ),
      ],
    );
  }

  Widget thumbImg() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffececec),
        image: decorationImage(),
        border: Border.all(color: Color(0xffececec), width: 2.0),
      ),
    );
  }

  decorationImage() {
    var thumbImgUrl = itemData['thumb'];
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      //返回网页获取图片
      return DecorationImage(
        image: NetworkImage(thumbImgUrl),
        fit: BoxFit.cover,
      );
    }
    return DecorationImage(
      image: ExactAssetImage('images/ic_img_default.jpg'),
      fit: BoxFit.cover,
    );
  }

  Widget timeRow() {
    return Row(
      children: <Widget>[
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffececec),
            image: DecorationImage(
              image: NetworkImage(itemData['authorImg']), fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            itemData['timeStr'],
            style: subTitleStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '${itemData['commCount']}',
                style: subTitleStyle,
              ),
              Image.asset(
                'images/ic_comment.png',
                width: 16.0,
                height: 16.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
