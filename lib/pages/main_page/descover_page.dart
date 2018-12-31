/// 发现界面
import 'package:flutter/material.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'components/descover_page_item.dart';

class DescoverPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DescoverPageState();
  }
}

class DescoverPageState extends State<DescoverPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageItem.paddingTop,
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_softwares.png'),
          StringConstants.DISCOVER_SOFTWARES,
            () => print('点击了 开源软件')
        ),
        PageItem.lineHalf,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_git.png'),
          StringConstants.DISCOVER_GIT,
            () => print('点击了 码云推荐')),
        PageItem.lineHalf,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_gist.png'),
          StringConstants.DISCOVER_GIST,
            () => print('点击了 代码片段')),
        PageItem.lineFull,
        PageItem.paddingTop,
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_scan.png'),
          StringConstants.DISCOVER_SCAN,
            () => print('点击了 扫一扫')),
        PageItem.lineHalf,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_shake.png'),
          StringConstants.DISCOVER_SHAKE,
            () => print('点击了 摇一摇')),
        PageItem.lineFull,
        PageItem.paddingTop,
        PageItem.lineFull,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_nearby.png'),
          StringConstants.DISCOVER_NEARBY,
            () => print('点击了 码云封面人物')),
        PageItem.lineHalf,
        PageItem(
          PageItem.getImageAsset('images/ic_discover_pos.png'),
          StringConstants.DISCOVER_POS,
            () => print('点击了 线下活动')),
        PageItem.lineFull,
      ]
    );
  }

}