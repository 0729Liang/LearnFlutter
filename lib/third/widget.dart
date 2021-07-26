import 'package:first_flutter_app/MyIconFont.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 描述：StatelessWidget
 * StatelessWidget用于不需要维护状态的场景，
 * 它通常在build方法中通过嵌套其它Widget来构建UI，在构建过程中会递归的构建其嵌套的Widget
 */
class Echo extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  Echo({Key key, @required this.text, this.backgroundColor: Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        color: backgroundColor,
        child: Text(text),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContextRouter();
          }));
        },
      ),
    );
  }
}
class ContextRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("查找父级")),
      body: Container(
        child: Builder(builder: (context) {
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 描述：ios风格
 */
class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CupertinoPageScaffold scaffold = CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text("press"),
          onPressed: () {
            print("CupertinoButton on Pressed");
          },
        ),
      ),
    );
    return scaffold;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TapboxA 管理自身状态.
//------------------------- TapboxA ----------------------------------
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector gestureDetector = new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'ActiveA' : 'InactiveA',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
    return gestureDetector;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ParentWidget 为 TapboxB 管理状态.
//------------------------ ParentWidget --------------------------------
class ParentWidgetState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidgetState> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------
class TapboxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector gestureDetector = new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? "ActiveB" : "InactiveB",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
    return gestureDetector;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------- ParentWidget ----------------------------
class ParentWeightStateC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWeightStateC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

//----------------------------- TapboxC ------------------------------
class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _TapboxCState();
  }
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onDoubleTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? "ActiveC" : "InActiveC",
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? new Border.all(color: Colors.teal[700], width: 10.0)
                : null),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CounterRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CounterWidget(
      initValue: -3,
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 描述：StatefulWidget State
 */
class CounterWidget extends StatefulWidget {
  final int initValue;

  const CounterWidget({Key key, this.initValue = 0});

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
// @override
// State<StatefulWidget> createState() {
//   return _CounterWidgetState();
// }

}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print("_CountWidgetState initValue:$_counter");
  }

  @override
  Widget build(BuildContext context) {
    print("_CountWidgetState build");
    Scaffold scaffold = Scaffold(
      appBar: AppBar(
        title: Text("自定义状态"),
      ),
      body: Center(child: Builder(
        builder: (context) {
          return Column(
            children: [
              FlatButton(
                color: Colors.blue,
                child: Text('$_counter'),
                //点击后计数器自增
                onPressed: () => setState(() => ++_counter),
              ),
              RaisedButton(
                onPressed: () {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  ScaffoldState state =
                  context.findAncestorStateOfType<ScaffoldState>();
                  if (state != null) {
                    //调用ScaffoldState的showSnackBar来弹出SnackBar
                    print("我是SncakButton1");
                    state.showSnackBar(
                        SnackBar(content: Text("我是SncakButton1")));
                  } else {
                    print("state is null");
                  }
                  ScaffoldState scaffoldState = Scaffold.of(context);
                  if (scaffoldState != null) {
                    //调用ScaffoldState的showSnackBar来弹出SnackBar
                    print("我是SncakButton2");
                    scaffoldState.showSnackBar(
                        SnackBar(content: Text("我是SncakButton2")));
                  } else {
                    print("scaffoldState is null");
                  }
                },
                child: Text("显示SncakButton"),
              ),
            ],
          );
        },
      )),
    );
    return scaffold;
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_CountWidgetState didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("_CountWidgetState deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("_CountWidgetState dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("_CountWidgetState reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_CountWidgetState didChangeDependencies");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class LearnTextAndStyle extends StatelessWidget {
  // 声明文本样式
  final textStyleFL = const TextStyle(
    fontFamily: 'FL',
  );

  // 声明文本样式
  final textStyleST = const TextStyle(
    fontFamily: 'ST',
  );

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: AppBar(title: Text("组件介绍测试")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "12345" * 25,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.5,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.0,
                    fontFamily: "Courier",
                    height: 1.5,
                    background: Paint()..color = Colors.amber,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              Text.rich(TextSpan(
                children: [
                  TextSpan(text: "Home:"),
                  TextSpan(
                    text: "www.baidu.com",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )
                ],
              )),
              DefaultTextStyle(
                //1.设置文本默认样式
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("hello world"),
                    Text("I am Jack"),
                    Text(
                      "I am Jack",
                      style: TextStyle(
                          inherit: false, //2.不继承默认样式
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                "方正兰亭粗黑体方正兰亭粗黑体",
                style: textStyleFL,
              ),
              Text(
                "方正粗雅宋简体方正粗雅宋简体",
                style: TextStyle(fontFamily: "ST"),
              )
            ],
          ),
        ),
      ),
    );
    return scaffold;
  }
}

class LearnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: AppBar(title: Text("按钮学习")),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                print("RaisedButton");
              },
              child: Text("RaisedButton"),
            ),
            FlatButton(
              onPressed: () {
                print("FlatButton");
              },
              child: Text("FlatButton"),
            ),
            OutlineButton(
              onPressed: () {
                print("OutlineButton");
              },
              child: Text("OutlineButton"),
            ),
            IconButton(
              onPressed: () {
                print("OutlineButton");
              },
              icon: Icon(Icons.thumb_up),
            ),
            RaisedButton.icon(
              onPressed: () {
                print("RaisedButton");
              },
              icon: Icon(Icons.thumb_up),
              label: Text("RaisedButton"),
            ),
            FlatButton.icon(
                onPressed: () {
                  print("FlatButton");
                },
                icon: Icon(Icons.send),
                label: Text("FlatButton")),
            OutlineButton.icon(
                onPressed: () {
                  print("OutlineButton");
                },
                icon: Icon(Icons.height),
                label: Text("OutlineButton")),
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.green[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.red,
              child: Text("Submit"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    return scaffold;
  }
}

class LearnImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: AppBar(
        title: Text("图片及 ICON"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage("images/cat.jpg"),
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.fitWidth,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.scaleDown,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 300,
              height: 300,
              fit: BoxFit.none,
            ),
            Image.asset(
              "images/cat.jpg",
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              color: Colors.teal,
              colorBlendMode: BlendMode.difference,
            ),
            Image(
              image: NetworkImage(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
              width: 300,
            ),
            Image.network(
              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              width: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.accessible,
                  color: Colors.green,
                ),
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MyIconFont.icon1,
                  color: Colors.red,
                  size: 50,
                ),
                Icon(
                  MyIconFont.icon2,
                  color: Colors.green,
                  size: 50,
                ),
                Icon(
                  MyIconFont.icon3,
                  color: Colors.red,
                  size: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );

    return scaffold;
  }
}

class LearnSwitchAndCheckBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LearnSwitchAndCheckBoxState();
  }
}

class _LearnSwitchAndCheckBoxState extends State<LearnSwitchAndCheckBoxRoute> {
  bool _switchSelect = true;
  bool _checkSelect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单选开关和复选框"),
      ),
      body: Column(
        children: [
          Switch(
              value: _switchSelect,
              onChanged: (value) {
                setState(() {
                  print("Switch value:{$value}");
                  _switchSelect = value;
                });
              }),
          Checkbox(
              value: _checkSelect,
              activeColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  print("Checkbox value:{$value}");
                  _checkSelect = value;
                });
              })
        ],
      ),
    );
  }
}

class LearnInputTextAndFrom extends StatelessWidget {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;
  GlobalKey _formKey = new GlobalKey<FormState>();

  LearnInputTextAndFrom() {
    _unameController.text = "Amarao";

    _unameController.addListener(() {
      print("listener name:${_unameController.text}");
    });

    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);

    focusNode1.addListener(() {
      print("has fouces:${focusNode1.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("输入框和表单"),
      ),
      body: Theme(
          data: Theme.of(context).copyWith(
              hintColor: Colors.grey[200], // 定义下划线颜色
              inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.yellow),
                  hintStyle: TextStyle(color: Colors.purple))),
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                    hintColor: Colors.grey[200], // 定义下划线颜色
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.yellow),
                        hintStyle: TextStyle(color: Colors.purple))),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      focusNode: focusNode1,
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: UnderlineInputBorder(
                            //未获得焦点的下划线
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: UnderlineInputBorder(
                            //获得焦点的下划线
                              borderSide: BorderSide(color: Colors.green))),
                      onChanged: (v) {
                        print("change name:$v");
                      },
                    ),
                    TextField(
                      focusNode: focusNode2,
                      decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock),
                        hintStyle: TextStyle(color: Colors.pink),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          // 写法 1
                          // FocusScope.of(context).requestFocus(focusNode2);
                          // 写法 2
                          if (focusScopeNode == null) {
                            focusScopeNode = FocusScope.of(context);
                          }
                          focusScopeNode.requestFocus(focusNode2);
                        },
                        child: Text("移动焦点")),
                    FlatButton(
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                        child: Text("关闭焦点"))
                  ],
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: true, // 是否自动校验
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          icon: Icon(Icons.person)),
                      validator: (v) {
                        print("验证用户名");
                        // 用户名不能为空，如果为空则提示“用户名不能为空”。
                        return v.trim().length > 0 ? null : "用户名不能为空";
                      },
                    ),
                    TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您登陆的密码",
                          icon: Icon(Icons.lock)),
                      obscureText: true,
                      validator: (v) {
                        print("验证密码");
                        // 密码不能小于6位，如果小于6为则提示“密码不能少于6位”
                        return v.trim().length >= 6 ? null : "密码不能少于 6 位";
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(15.0),
                                child: Text("登陆"),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  //在这里不能通过此方式获取FormState，context不对
                                  //print(Form.of(context));

                                  // 通过_formKey.currentState 获取FormState后，
                                  // 调用validate()方法校验用户名密码是否合法，校验
                                  // 通过后再提交数据。
                                  if ((_formKey.currentState as FormState)
                                      .validate()) {
                                    print("*******验证通过提交数据");
                                  } else {
                                    print("*******验证未通过提交数据");
                                  }
                                },
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class LearnProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("进度指示器"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: 0.5,
              ),
              SizedBox(
                height: 30,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
              // 圆形进度条直径指定为100
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .7,
                ),
              ),
            ],
          ),
        ));
  }
}