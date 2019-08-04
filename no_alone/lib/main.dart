import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_alone/code_review.dart';
import 'package:random_string/random_string.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '图片验证码'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _codeLength = 4;
  String _codeStr = randomAlphaNumeric(4);

  TextEditingController _controller = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_codeLength),
                  WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))
                ],
                controller: _controller,
                focusNode: _node,
                onChanged: (text) {
                  debugPrint(text.trim() + _codeStr);
                },
                onSubmitted: (text) {
                  // 去掉前后空格 全部降级不区分大小写 不区分字母大小写
                  text = text.trim()..toLowerCase();
                  if (text == _codeStr.toLowerCase()) {
                    debugPrint('you can enter other strings');
                  }
                },
                decoration: InputDecoration(hintText: 'enter code'),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CodeReview(
                text: _codeStr,
                onTap: (text) {
                  setState(() {
                    _codeStr = text;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
