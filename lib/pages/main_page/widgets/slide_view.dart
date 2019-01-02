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

class SlideViewState extends State<SlideView> {
  List slideData;
  bool isDeactivate = false;
  SwiperController _controller;

  SlideViewState(this.slideData);

  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();
  }

  @override
  void deactivate() {
    super.deactivate();
    isDeactivate ? _controller.startAutoplay() : _controller.stopAutoplay();
    isDeactivate = !isDeactivate;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return new Swiper(
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 7.0),
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
      fade: 0.3,
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
