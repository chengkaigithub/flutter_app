import 'dart:convert';

/// 资讯界面
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/api_constants.dart';
import 'package:flutter_app/pages/main_page/news_detail_page.dart';
import 'package:flutter_app/pages/main_page/widgets/listview_end_footer.dart';
import 'package:flutter_app/pages/main_page/widgets/news_item_view.dart';
import 'package:flutter_app/pages/main_page/widgets/slide_view.dart';
import 'package:flutter_app/util/net_utils.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage> {
  var listData;
  var slideData;
  var curPage = 1;
  var listTotalSize = 0;
  bool isLoading = false;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    getNewsList(false);
    _controller.addListener(() {
      //判断是否滑动到底部了
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getNewsList(true);
      }
    });
  }

  //获取新闻列表，isLoadMore表示是否加载更多数据
  Future<Null> getNewsList(bool isLoadMore) async {
    if (!isLoading) {
      isLoading = true;
      curPage = isLoadMore ? curPage++ : 1;
      String url = Api.NEWS_LIST;
      url += '?pageIndex=$curPage&pageSize=10';
      //http://osc.yubo725.top/news/list?pageIndex=2&pageSize=10
      await NetUtils.get(url).then((data) {
        if (data != null) {
          Map<String, dynamic> map = json.decode(data);
          if (map['code'] == 0) {
            var msg = map['msg'];
            //总的资讯条数
            listTotalSize = msg['news']['total'];
            //data数据内容
            var _listData = msg['news']['data'];
            var _slideData = msg['slide'];

            setState(() {
              if (!isLoadMore) {
                //不是加载更多，则直接赋值
                listData = _listData;
              } else {
                //加载更多
                List list = new List();
                list.addAll(listData);
                list.addAll(_listData);

                //加载完了所有数据
                if (list.length >= listTotalSize) {
                  list.add(Constants.END_LINE_TAG);
                }

                listData = list;
              }
              slideData = _slideData;
            });
          }
        }
        isLoading = false;
      });
      return null;
    }
  }

  //下拉刷新
  Future<Null> _pullToRefresh() {
    return getNewsList(false);
  }


  Widget buildProgress() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      //还没有数据
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      //有数据
      return RefreshIndicator(
        child: ListView.builder(
          itemCount: listData.length * 2 + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == listData.length * 2) {
              return buildProgress();
            } else {
              return renderRow(index);
            }
          },
          controller: _controller,
        ),
        onRefresh: _pullToRefresh,
      );
    }
  }

  Widget renderRow(int index) {
    if (index == 0) {
      return Container(
        height: 180.0,
        child: SlideView(slideData),
      );
    }

    index--;

    if (index.isOdd) {
      return Divider(height: 1.0);
    }
    index = index ~/ 2;
    var itemData = listData[index];

    //如果到最底端了，绘制底线
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return ListViewEndFooter();
    }

    return InkWell(
      child: NewsItemView(itemData),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return NewsDetailPage(id: itemData['detailUrl']);
          },
        ));
      },
    );
  }
}