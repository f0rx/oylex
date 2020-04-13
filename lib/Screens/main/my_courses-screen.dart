import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/components/main/courses-tab.dart';

class MyCoursesScreen extends StatefulWidget {
  static final routeName = "/my_courses-screen";

  MyCoursesScreen({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  int _duration = 200;
  Widget _child = Text("Recent Courses stand here");
  List<Widget> _list = [
    Text("Recent Courses stand here"),
    Text("Lorem ipsum dolor sit. ALL Courses"),
    Text("Currently Studying here"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoursesTab(
        height: deviceHeight(context) * 0.095,
        tabWidth: deviceWidth(context) -
            (deviceLeftMargin(context) + deviceRightMargin(context)),
        animationDuration: _duration,
        onPressed: (int index) {
          setState(() {
            _child = _list[index];
          });
        },
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: defaultEdgeSpacing(context),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: _duration),
          child: _child,
          transitionBuilder: (child, animation) {
            final offsetAnimation = TweenSequence([
              TweenSequenceItem(
                  tween: Tween<Offset>(
                      begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)),
                  weight: 1),
              TweenSequenceItem(
                  tween: ConstantTween(Offset(0.0, 0.0)), weight: 3),
              TweenSequenceItem(
                  tween: Tween<Offset>(
                      begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0)),
                  weight: 1)
            ]).animate(animation);
            return ClipRect(
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            List<Widget> children = previousChildren;
            if (currentChild != null)
              children = children.toList()..add(currentChild);
            return Stack(
              children: children,
              alignment: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}