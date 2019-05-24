import 'package:flutter/material.dart';

/*  
    Yet another beautiful Navbar by Aayush Malhotra(AadumKhor).
    Use it well or don't coz it's gonna make your project wayyyy   
    better 
    ***************THANK YOU********************
*/

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('BarNavBar'),
        ),
        body: Center(
          child: Container(
            child: Text('I am IronMan'),
          ),
        ),
      ),
    );
  }
}

class BarNavbar extends StatefulWidget {
  final List<IconData> icons;
  final List<String> names;
  final List<Color> colors;
  final Color bgColor;
  final Color textColor;
  final int selectedIndex;
  final Function tapCallback;

  BarNavbar(
      {Key key,
      this.bgColor = Colors.white,
      this.icons = const [],
      this.colors = const [],
      this.names = const [],
      this.selectedIndex = 0,
      this.tapCallback,
      this.textColor = Colors.black});
  @override
  _BarNavbarState createState() => _BarNavbarState(selectedIndex);
}

class _BarNavbarState extends State<BarNavbar> {
  int selectedIndex; // selected currently
  int newIndex; // new one that has to be updated

  Animation<double> posAnim; //animation of the selected bar
  Animation<Color> colorAnim; //color change
  Animation<double> squeezAnim; //squeez to add a good touch
  Animation<double>
      stretchAnim; //coz every action has equal and opposite reaction
  Animation<double> textAnim; //coz I wanna move the text as well

  AnimationController controller; //much needed

  _BarNavbarState(this.selectedIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
