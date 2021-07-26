import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class LearnSecondRouter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("第一个 Flutter 应用"),),
      body: Column(
        children: [
          // 添加一个FlatButton按钮,打开新的路由界面
          FlatButton(
            child: Text("打开未命名路由"),
            textColor: Colors.blue, // 将按钮文字颜色设置为蓝色
            onPressed: () {
              // 点击该按钮后就会打开新的路由页面，
              // 导航到新路由
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewRoute();
              }));
            },
          ),
          FlatButton(
            child: Text("打开命名路由"),
            textColor: Colors.blue, // 将按钮文字颜色设置为蓝色
            onPressed: () {
              // 点击该按钮后就会打开新的路由页面，
              // 通过路由名打开新路由页
              Navigator.pushNamed(context, "tip_route");
            },
          ),
          FlatButton(
            child: Text("路由传参"),
            textColor: Colors.blue, // 将按钮文字颜色设置为蓝色
            onPressed: () {
              // 点击该按钮后就会打开新的路由页面，
              // 导航到新路由
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RouterTestRoute();
              }));
            },
          ),
          FlatButton(
            child: Text("命名路由传参"),
            textColor: Colors.green,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed("name_route", arguments: "代号4");
            },
          ),
          RandomWordsWidget(),
          Image.asset(
            'assets/images/head.png',
            width: 100,
          ),
        ],
      ),
    );
  }

}
////////////////////////////////////////////////////////////////////////////////

// 创建一个新路由，命名“NewRoute”
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

/**
 * 描述：
 * 我们创建一个TipRoute路由，它接受一个提示文本参数，负责将传入它的文本显示在页面上，
 * 另外TipRoute中我们添加一个“返回”按钮，点击后在返回上一个路由的同时会带上一个返回参数，
 */
class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key key, @required this.text // 接收一个text参数
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回键"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 打开路由TipRoute
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          // 打开TipRoute,并等待返回结果
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(
                // 路由参数
                text: "我是提示xxxx，路由传参");
          }));
          print("路由返回值：$result");
        },
        // 输出TipRoute路由返回结果
        child: Text("打开提示页"),
      ),
    );
  }
}

// 命名路由传参
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("命名路由传参"),
      ),
      body: Center(
        child: Text("命名路由传参：$args"),
      ),
    );
  }
}

// 使用第三方包生成随机字符
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符
    final wordPair = new WordPair.random();
    // DefaultAssetBundle.of(context)
    //     .loadString('assets/test.txt')
    //     .then((value) => print("assets/test.txt:$value"));
    loadAsset().then((value) => print("YML assets/test.txt:${value}"));
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text("第三方包生成随机字符:${wordPair.toString()}"),
    );
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/test.txt');
}





