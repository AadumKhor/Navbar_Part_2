import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cicular Navbar'),
        ),
        body: Center(
          child: Container(
            child: Text('I can do this all day'),
          ),
        ),
      ),
    );
  }
}

class CircularNavbar extends StatefulWidget {
  final List<IconData> icons;
  final List<String> names;
  final List<Color> colors;
  final int selectedIndex;
  final Function tapCallback;

  CircularNavbar(
      {Key key,
      this.colors,
      this.icons,
      this.names,
      this.selectedIndex,
      @required this.tapCallback});
  @override
  _CircularNavbarState createState() => _CircularNavbarState();
}

class _CircularNavbarState extends State<CircularNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
