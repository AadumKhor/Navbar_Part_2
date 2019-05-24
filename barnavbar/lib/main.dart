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

class _BarNavbarState extends State<BarNavbar>
    with SingleTickerProviderStateMixin {
  Size _size;

  double squeezLength = 10.0; //squeezLength of the bar
  double fullLength = 25.0; // full Length of the bar
  int selectedIndex; // selected currently
  int newIndex; // new one that has to be updated

  Animation<double> posAnim; //animation of the selected bar
  Animation<double> colorAnim;
  //color change** for the time being double but I think color would be better
  Animation<double> squeezAnim; //squeez to add a good touch
  Animation<double>
      stretchAnim; //coz every action has equal and opposite reaction
  Animation<double> textAnim; //coz I wanna move the text as well

  AnimationController controller; //much needed

  _BarNavbarState(this.selectedIndex);

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    posAnim = new Tween<double>(
            begin: selectedIndex * 1.0, end: (selectedIndex + 1) * 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    colorAnim = new Tween<double>(
            begin: selectedIndex * 1.0, end: (selectedIndex + 1) * 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    squeezAnim = new Tween(begin: fullLength, end: squeezLength).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.15, curve: Curves.ease)));
    stretchAnim = new Tween(begin: squeezLength, end: fullLength).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.15, curve: Curves.ease)));
    controller.addListener(() => setState(() {}));
    controller.addStatusListener((status) {
      if (controller.isCompleted) {
        selectedIndex = newIndex;
        controller.reset();
      }
    });
    super.initState();
  }

  List<Widget> smallIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < widget.icons.length; i++) {
      var a = Expanded(
        child: Container(
          child: InkResponse(
            onTap: () {
              //   tapped(i, true);
            },
            child: Opacity(
              opacity: getOpacityForIndex(i),
              child: Container(
                height: kBottomNavigationBarHeight * 1.6,
                width: _size.width / 5,
                child: Icon(
                  widget.icons[i],
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
      icons.add(a);
    }
    return icons;
  }

  //method copied from stackoverflow
  double getOpacityForIndex(int index) {
    if (controller.isAnimating) {
      var dist = (index - posAnim.value).abs();
      if (dist >= 1) {
        return 1;
      } else {
        return dist;
      }
    } else {
      return selectedIndex == index ? 0 : 1;
    }
  }

  // to check and update the interactions
  void tapped(int index, bool userInteraction) {
    if (userInteraction) {
      widget.tapCallback(index);
    }
    newIndex = index;
    posAnim = Tween<double>(begin: selectedIndex * 1.0, end: index * 1.0)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.forward();
  }

  //function to update the widget
  @override
  void didUpdateWidget(BarNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) {
      return;
    }
    tapped(widget.selectedIndex, false);
    // function to check if the button is tapped
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
