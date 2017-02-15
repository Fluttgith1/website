import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 5, // Removing drop shadow cast by the AppBar.
        title: new Text(config.title),
      ),
      body: new Center(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Expanded(
              child: new Image.asset('assets/images/pic1.jpg'),
            ),
            new Expanded(
              flex: 2,
              child: new Image.asset('assets/images/pic2.jpg'),
            ),
            new Expanded(
              child: new Image.asset('assets/images/pic3.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

// Row({Key key,
//   MainAxisAlignment mainAxisAlignment: MainAxisAlignment.start,
//   MainAxisSize mainAxisSize: MainAxisSize.max,
//   CrossAxisAlignment crossAxisAlignment: CrossAxisAlignment.center,
//   TextBaseline textBaseline,
//   List<Widget> children: const [] })
