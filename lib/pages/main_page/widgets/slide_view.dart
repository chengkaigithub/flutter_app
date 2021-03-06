import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page/news_detail_page.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  slideData != null ? slideData[index]['imgUrl'] : '',
                  fit: BoxFit.fitHeight,
                  height: 188.0,
                ),
              ),
              new Material(
                child: Container(
                  width: screenWidth,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Container(
                      height: 18.0,
                      child: Center(
                        child: Text(
                          slideData != null ? slideData[index]['title'] : '',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(6.0),
                  bottom: Radius.circular(0.0)
                ),
                color: Color(0x20000000),
              ),
            ],
          )
        );
      },
      itemCount: slideData != null ? slideData.length : 0,
      viewportFraction: 0.8,
      scale: 0.8,
      autoplay: true,
      duration: 1500,
      onTap: (index) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailPage(
                id: slideData != null ? slideData[index]['detailUrl'] : ''
              );
            },
          )
        );
      },
      pagination: new SwiperPagination(
        margin: new EdgeInsets.all(8.0),
        alignment: Alignment.bottomCenter,
        builder: SwiperPagination.dots
      ),
      indicatorLayout: PageIndicatorLayout.NONE,
//      loop: false,
    );
  }
}
