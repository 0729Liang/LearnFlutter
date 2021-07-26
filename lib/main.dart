import 'dart:async';
import 'dart:developer';
import 'package:english_words/english_words.dart';
import 'package:first_flutter_app/fourth/LearnFourth.dart';
import 'package:first_flutter_app/third/LearnThird.dart';

import 'package:flutter/material.dart'; // Android默认的视觉风格
import 'package:flutter/cupertino.dart'; //导入cupertino widget库 iOS视觉风格
import 'package:flutter/services.dart' show rootBundle;
import 'package:first_flutter_app/second/LearnSecond.dart';
import 'third/widget.dart';

void main() {
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: new ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, "Intercepted: $line");
    }),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter D.emo Home Page'),
      initialRoute: "/",
      //名为"/"的路由作为应用的home(首页)
      // 注册路由表
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
        // 注册自定义路由
        "new_page": (context) => NewRoute(),
        "tip_route": (context) => TipRoute(text: "命名路由TipRoute"),
        "name_route": (context) => EchoRoute(),
      },
      onGenerateRoute: (RouteSettings setting) {
        return MaterialPageRoute(builder: (context) {
          String routeName = setting.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
        });
      },
    );
  }
}

/**
 * 描述：
 * Stateful widget可以拥有状态
 * Stateful widget至少由两个类组成：
    一个StatefulWidget类。
    一个 State类
 */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      // assert(_counter < 5);
      // debugger(when: _counter > 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have2 pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              RaisedButton(
                  child: Text("第二章：第一个 Flutter 应用"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LearnSecondRouter();
                    }));
                  }),
              FlatButton(
                  child: Text("第三章：基础组件"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LearnThirdRouter();
                    }));
                  }),
              OutlineButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LearnFourthRouter();
                  }));
                },
                child: Text("第四章：布局类组件"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
