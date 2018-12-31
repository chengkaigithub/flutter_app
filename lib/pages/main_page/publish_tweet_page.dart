import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';

/// 动弹界面
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/configs/string_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/util/data_utils.dart';
import 'package:image_picker/image_picker.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublishTweetPageState();
  }
}

class PublishTweetPageState extends State<PublishTweetPage> {
  TextEditingController _controll = new TextEditingController();
  List<File> fileList = new List();
  Future<File> _imageFile;
  bool isLoading = false;
  String msg = "";

  sendTweet(context, token) async {
    if (token == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(StringConstants.NOT_LOGIN)));
      return;
    }
    String content = _controll.text;
    if (content == null || content.length == 0 || content
      .trim()
      .length == 0) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(StringConstants.PLEASE_INPUT_MOBM_INFO)));
    }
    try {
      Map<String, String> params = Map();
      params['msg'] = content;
      params['access_token'] = token;

      var request = http.MultipartRequest("POST", Uri.parse(Api.PUB_TWEET));

      request.fields.addAll(params);

      if (fileList != null && fileList.length > 0) {
        for (File f in fileList) {
          var stream = http.ByteStream(DelegatingStream.typed(f.openRead()));
          var length = await f.length();
          var filename = f.path.substring(f.path.lastIndexOf('/') + 1);
          request.files.add(
            http.MultipartFile('img', stream, length, filename: filename));
        }
      }
      setState(() {
        isLoading = true;
      });

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        //{"error_description":"操作成功完成","error":"200"}
        if (value != null) {
          var obj = json.decode(value);
          var error = obj['error'];
          setState(() {
            if (error != null && error == '200') {
              setState(() {
                isLoading = false;
                msg = StringConstants.PUBLISH_SUCCESS;
                fileList.clear();
              });
              _controll.clear();
            } else {
              setState(() {
                isLoading = false;
                msg = "${StringConstants.PUBLISH_FAILURE}：$error";
              });
            }
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.SEND_MOVE_BOMB,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          new Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  //发送动弹
                  DataUtils.isLogin().then((isLogin) {
                    if (isLogin) {
                      return DataUtils.getAccessToken();
                    } else {
                      return null;
                    }
                  }).then((token) {
                    sendTweet(context, token);
                  });
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            _imageFile != null) {
            fileList.add(snapshot.data);
            _imageFile = null;
          }
          return getBody();
        },
      ),
    );
  }

  Widget getBody() {
    var textField = TextField(
      decoration: InputDecoration(
        hintText: StringConstants.PLEASE_INPUT_BOMB_INFO,
        hintStyle: TextStyle(color: Color(0xFF808080)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      maxLines: 6,
      maxLength: 150,
      controller: _controll,
    );
    var gridView = Builder(
      builder: (BuildContext context) {
        return GridView.count(
          crossAxisCount: 4,
          children: List.generate(
            fileList.length + 1,
              (index) {
              var content;
              if (index == 0) {
                content = GestureDetector(
                  onTap: () {
                    //添加图片
                    pickImage(context);
                  },
                  child: Center(
                    child: Image.asset(
                      "images/ic_add_pics.png",
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
                );
              } else {
                content = Center(
                  child: Image.file(
                    fileList[index - 1],
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.all(2.0),
                width: 80.0,
                height: 80.0,
                color: Color(0xffececec),
                child: content,
              );
            },
          ),
        );
      },
    );

    var children = [
      Text(
        StringConstants.UPLOAD_IMG_HINT,
        style: new TextStyle(fontSize: 12.0),
      ),
      textField,
      new Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 200.0,
        child: gridView,
      )
    ];
    if (isLoading) {
      children.add(Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } else {
      children.add(Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          child: Text(msg),
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: children,
      ),
    );
  }

  //从相机获取，从图库获取
  pickImage(context) {
    //如果添加了9张，则提示不能再添加
    if (fileList.length >= 9) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(StringConstants.MAX_IMAGES_SIZE_NINE)));
      return;
    }
    showModalBottomSheet(context: context, builder: _bottomSheetBuilder);
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    return Container(
      height: 182.0,
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
        child: new Column(
          children: <Widget>[
            _renderBottomMenuItem(
              StringConstants.TAKE_FROM_CAMERA, ImageSource.camera),
            new Divider(
              height: 2.0,
            ),
            _renderBottomMenuItem(
              StringConstants.SELECT_FROM_LOCAL, ImageSource.gallery)
          ],
        ),
      ));
  }

  _renderBottomMenuItem(title, ImageSource source) {
    var item = new Container(
      height: 60.0,
      child: new Center(child: new Text(title)),
    );
    return new InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          _imageFile = ImagePicker.pickImage(source: source);
        });
      },
    );
  }
}