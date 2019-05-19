import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final List<IconData>
      icons; //icons taht it will contain we can add text as well
  final int selectedIndex; // which icon is selected
  final Color bgColor; //color of the navbar that can be varied by the user

  final Function touchCallback; //callback to check if navbar is clicked

  NavBar(
      {Key key,
      this.icons = const [],
      this.bgColor = Colors.black,
      this.selectedIndex = 0,
      @required this.touchCallback})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  int selectedIndex = 0; // which is selected
  int newIndex = 0; // new one that is to be selected
  final _circleBottomPosition = 50 + kBottomNavigationBarHeight * 0.4;

  Animation<double> positionAnim; // when it is positioned
  Animation<double> riseAnim; // when it rises  to place
  Animation<double> sinkAnim; // when it falls to place
  AnimationController controller; // controller as usual

  Size _size; // to determine the size of the circle

  _NavBarState({this.selectedIndex});

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    positionAnim = new Tween<double>(
            begin: selectedIndex * 1.0, end: (selectedIndex + 1) * 1.0)
        .animate(CurvedAnimation(curve: Curves.bounceIn, parent: controller));
    sinkAnim = new Tween<double>(begin: 0.0, end: _circleBottomPosition)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.15, curve: Curves.ease)));
    riseAnim = new Tween<double>(begin: _circleBottomPosition, end: 0.0)
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.5, 1.0, curve: Curves.ease)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
