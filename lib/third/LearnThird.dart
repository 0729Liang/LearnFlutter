import 'package:first_flutter_app/third/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LearnThirdRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("第三章:基础组件"),),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Echo(text: "查找父级"),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) {
                      return CupertinoTestRoute();
                    }));
              },
              child: Text("Cupertino"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TapboxA();
                }));
              },
              child: Text("TapboxA"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ParentWidgetState();
                }));
              },
              child: Text("TapboxB"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ParentWeightStateC();
                }));
              },
              child: Text("TapboxC"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounterRouter();
                }));
              },
              child: Text("点击跳转自定义状态"),
              color: Colors.blue,
              textColor: Colors.red,
            ),
            RaisedButton(
              onPressed: () {
                try {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  ScaffoldState state =
                  context.findAncestorStateOfType<ScaffoldState>();
                  if (state != null) {
                    //调用ScaffoldState的showSnackBar来弹出SnackBar
                    state.showSnackBar(
                        SnackBar(content: Text("我是SncakButton")));
                  } else {
                    print("state is null");
                  }
                  ScaffoldState scaffoldState = Scaffold.of(context);
                  if (scaffoldState != null) {
                    //调用ScaffoldState的showSnackBar来弹出SnackBar
                    scaffoldState.showSnackBar(
                        SnackBar(content: Text("我是SncakButton")));
                  } else {
                    print("scaffoldState is null");
                  }
                } catch (e, stack) {
                  print("错误:$e");
                }
              },
              child: Text("显示SnackButton"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnTextAndStyle();
                }));
              },
              child: Text("3.3文本及样式"),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnButton();
                }));
              },
              child: Text("3.4按钮"),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnImage();
                }));
              },
              child: Text("3.5图片及 ICON"),
            ),
            RaisedButton(
              shape: CircleBorder(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnSwitchAndCheckBoxRoute();
                }));
              },
              child: Text("3.6单选开关和复选框"),
            ),
            RaisedButton(
                child: Text("3.7 输入框和表单"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return LearnInputTextAndFrom();
                  }));
                }),
            FlatButton(
                child: Text("3.8 进度指示器"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return LearnProgressIndicator();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
