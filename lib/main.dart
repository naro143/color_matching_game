import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color matching game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _r = 0;
  int _g = 0;
  int _b = 0;
  bool _ans;
  List _color = [];

  List createColor() {
    List color = [];
    List colorLabel = ["Red", "Green", "Blue", "Multiple"];
    String maxColor;
    int max = 0;
    for (int i = 0; i < 3; i++) {
      int num = 85 * Random().nextInt(3);
      color.add(num);
      if (max < num) {
        max = num;
        maxColor = colorLabel[i];
      } else if (max == num) {
        maxColor = colorLabel[3];
      }
    }
    color.add(maxColor);
    return color;
  }

  @override
  void initState() {
    super.initState();
    _ans = false;
    setState(() {
      _color = createColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Matching Game'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Theme color",
          ),
          SizedBox(height: 10.0),
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(_color[0], _color[1], _color[2], 1.0),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "The biggest one is ${_color[3]}",
            style: TextStyle(
                color: Color.fromRGBO(_color[0], _color[1], _color[2], 1.0)),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _r = _r == 255 ? 0 : _r + 85;
                  });
                },
                color: Color.fromRGBO(_r, 0, 0, 1),
                textColor: Colors.white,
                child: Text(
                  "RED",
                ),
              ),
              SizedBox(width: 10.0),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _g = _g == 255 ? 0 : _g + 85;
                  });
                },
                color: Color.fromRGBO(0, _g, 0, 1),
                textColor: Colors.white,
                child: Text(
                  "GREEN",
                ),
              ),
              SizedBox(width: 10.0),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _b = _b == 255 ? 0 : _b + 85;
                  });
                },
                color: Color.fromRGBO(0, 0, _b, 1),
                textColor: Colors.white,
                child: Text(
                  "BLUE",
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          _ans
              ? Column(
                  children: <Widget>[
                    Text(
                      "Your color",
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(_r, _g, _b, 1.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      _r == _color[0] && _g == _color[1] && _b == _color[2]
                          ? "Match!"
                          : "Not Match",
                      style: TextStyle(color: Color.fromRGBO(_r, _g, _b, 1.0)),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {
              setState(() {
                _color = _ans ? createColor() : _color;
                _r = _ans ? 0 : _r;
                _g = _ans ? 0 : _g;
                _b = _ans ? 0 : _b;
                _ans = !_ans;
              });
            },
            child: Text(
              _ans ? "NEXT COLOR" : "SHOW RESULT",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
