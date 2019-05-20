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
  double kCircleSize = 62.0;

  Animation<double> positionAnim; // when it is positioned
  Animation<double> riseAnim; // when it rises  to place
  Animation<double> sinkAnim; // when it falls to place
  AnimationController controller; // controller as usual

  Size _size; // to determine the size of the circle

  _NavBarState({this.selectedIndex}); // need to access this to update state

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
    controller.addListener(() => setState(() {}));
    controller.addStatusListener((status) {
      if (controller.isCompleted) {
        selectedIndex = newIndex;
        controller.reset();
      }
    });
    super.initState();
  }

  // when the icons are in natural state they would be according
  // to this list.
  List<Widget> smallIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < widget.icons.length; i++) {
      var a = Expanded(
        child: Container(
          child: InkResponse(
            onTap: () {
              tapped(i, true);
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
      var dist = (index - positionAnim.value).abs();
      if (dist >= 1) {
        return 1;
      } else {
        return dist;
      }
    } else {
      return selectedIndex == index ? 0 : 1;
    }
  }

  // to check and update teh interactions
  void tapped(int index, bool userInteraction) {
    if (userInteraction) {
      widget.touchCallback(index);
    }
    newIndex = index;
    positionAnim = Tween<double>(begin: selectedIndex * 1.0, end: index * 1.0)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.forward();
  }

  //function to update the widget
  @override
  void didUpdateWidget(NavBar oldwidget) {
    // super.didUpdateWidget(oldWidget); // ? declare in order to access previous state
    if (oldwidget.selectedIndex == widget.selectedIndex) {
      return;
    }
    tapped(widget.selectedIndex,
        false); // function to check if the button is tapped
  }

  // to ensure it is at the poistion we want
  double getCircleYPosition() {
    if (!controller.isAnimating) {
      return 0;
    }

    if (controller.value < 0.5) {
      return sinkAnim.value;
    } else {
      return riseAnim.value;
    }
  }

  // get the selected icon
  Icon getMainIcon() {
    IconData icon;
    if (controller.value < 0.5) {
      icon = widget.icons[selectedIndex];
    } else {
      icon = widget.icons[newIndex];
    }
    return Icon(
      icon,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final sectionWidth = _size.width / widget.icons.length;
    final circleLeftPadding = (sectionWidth - kCircleSize) / 2;
    return Container(
      color: widget.bgColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: circleLeftPadding,
            top: getCircleYPosition(),
            child:Container(
              margin: EdgeInsets.only(left: circleLeftPadding),
              child: SizedBox(
                height: kCircleSize,
                width: kCircleSize,
                child: Material(
                  color: Colors.black,
                  elevation: 2.0,
                  type: MaterialType.circle,
                  clipBehavior: Clip.antiAlias,
                  child: getMainIcon(),
                ),
              ),
            )
          ),
          ClipPath(
            clipBehavior: Clip.antiAlias,
            clipper: NavBarClipper(
              controller.isAnimating
                  ? positionAnim.value
                  : selectedIndex * 1.0,
              widget.icons.length
            ),
            child: Container(
              height: kBottomNavigationBarHeight * 1.6,
              width: _size.width,
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Container(
                  margin:
                      EdgeInsets.only(top: kBottomNavigationBarHeight * 0.4),
                  height: kBottomNavigationBarHeight * 1.2,
                  width: _size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: smallIcons(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarClipper extends CustomClipper<ClipOval>{
  @override
  getClip(Size size) {
    
    return null;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) =>false;

}
