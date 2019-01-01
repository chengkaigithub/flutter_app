import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page/news_detail_page.dart';

class SlideView extends StatefulWidget {
  final data;

  SlideView(this.data);

  @override
  State<StatefulWidget> createState() {
    return SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
  with SingleTickerProviderStateMixin {
  List slideData;
  TabController tabController;

  SlideViewState(this.slideData);

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: slideData == null ? 0 : slideData.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    double screenWidth = MediaQuery
      .of(context)
      .size
      .width;

    if (slideData != null && slideData.length > 0) {
      for (var i = 0; i < slideData.length; i++) {
        var item = slideData[i];
        var imgUrl = item['imgUrl'];
        var title = item['title'];
        var detailUrl = item['detailUrl'];

        items.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NewsDetailPage(id: detailUrl);
                  },
                )
              );
            },
            child: Stack(
              children: <Widget>[
                Image.network(imgUrl, width: screenWidth),
                Container(
                  width: screenWidth,
                  color: Color(0x50000000),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Container(
                      height: 18.0,
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    }

    return TabBarView(
      children: items,
      controller: tabController,
    );
  }
}
