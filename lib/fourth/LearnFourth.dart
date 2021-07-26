import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearnFourthRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局类组件"),
      ),
      body: Column(
        children: [
          RaisedButton(
              child: Text("线性布局"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnRowAndColumn1();
                }));
              }),
          RaisedButton(
              child: Text("线性布局2"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnRowAndColumn2();
                }));
              }),
          RaisedButton(
              child: Text("线性布局3"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnRowAndColumn3();
                }));
              }),
          RaisedButton(
              child: Text("弹性布局"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnFlexLayout();
                }));
              }),
          RaisedButton(
              child: Text("流式布局Wrap"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnWarp();
                }));
              }),
          RaisedButton(
              child: Text("流式布局Flow"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnFlow();
                }));
              }),
          RaisedButton(
              child: Text("层叠布局 1"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnStack1();
                }));
              }),
          RaisedButton(
              child: Text("层叠布局 2"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnStack2();
                }));
              }),
          RaisedButton(
              child: Text("对齐与相对定位"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LearnAlign();
                }));
              }),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
class LearnRowAndColumn1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局"),
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("hello world,"), Text("I am Jack.")],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("hello world,"), Text("I am Jack.")],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[Text("hello world,"), Text("I am Jack.")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.rtl,
                children: [Text("hello world,"), Text("I am Jack.")],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Text(
                    " hello world ",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(" I am Jack "),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Text(
                    " hello world ",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(" I am Jack "),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LearnRowAndColumn2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局2"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("hi"),
          Text("world"),
        ],
      ),
    );
  }
}

class LearnRowAndColumn3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局3"),
      ),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                  children: <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
class LearnFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹性布局"),
      ),
      body: Column(
        children: [
          // FLex 的两个子 Widget按照 1：2 来占据空间
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 20,
                    color: Colors.green,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 100,
              // Flex 的三个子 Widget,在垂直方向按 2：1 来占用 100 像素的空间
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
class LearnWarp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("流式布局"),
      ),
      body: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, // 沿主轴方向居中
        children: [
          new Chip(
            label: new Text("1AAAAa"),
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("A"),
            ),
          ),
          new Chip(
            label: new Text("2BBBBb"),
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("B"),
            ),
          ),
          new Chip(
            label: new Text("3CCCCc"),
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("C"),
            ),
          ),
          new Chip(
            label: new Text("4DDDDd"),
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("D"),
            ),
          ),
        ],
      ),
    );
  }
}

class LearnFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("流式布局 Flow"),
      ),
      body: Flow(
        delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
        children: <Widget>[
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.red,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.green,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.blue,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.yellow,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.brown,
          ),
          new Container(
            width: 80.0,
            height: 80.0,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // paintChildren 的主要任务是确定每个子widget位置
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    // 由于Flow不能自适应子widget的大小，我们通过在getSize返回一个固定大小来指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

////////////////////////////////////////////////////////////////////////////////////////
class LearnStack1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("层叠布局"),
      ),
      body: ConstrainedBox(
        //通过ConstrainedBox来确保Stack占满屏幕
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: [
            Container(
              child: Text(
                "Hello world",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              child: Text("I am Jack"),
              left: 18.0,
            ),
            Positioned(
              child: Text("Your friend"),
              top: 18.0,
            )
          ],
        ),
      ),
    );
  }
}

class LearnStack2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("层叠布局"),
        ),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand, // 未定位widget占满Stack整个空间
          children: [
            Positioned(
              child: Text("I am Jack"),
              left: 18.0,
            ),
            Container(
              child: Text(
                "Hello world",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              child: Text("Your friend"),
              top: 18.0,
            ),
          ],
        ));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
class LearnAlign extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("对齐与相对定位"),),
      body: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            color: Colors.red[50],
            child: Align(
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment.bottomLeft,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            color: Colors.yellow[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment(0,0),
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.pink[50],
            child: Align(
              alignment: FractionalOffset(0.5, 0.5),
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text("xxx"),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.green),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text("xxx"),
            ),
          )
        ],
      ),
    );
  }
}
