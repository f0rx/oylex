import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oylex/Foundation/Utils/app_colors.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Foundation/Utils/routes.dart';
import 'package:oylex/Models/RouteArgs/permission-args.dart';
import 'package:oylex/Models/RouteArgs/route-args.dart';

class PermissionComponent extends StatefulWidget {
  static final routeName = "/permission-component";

  @override
  _PermissionComponentState createState() => _PermissionComponentState();
}

class _PermissionComponentState extends State<PermissionComponent> {
  String _image;
  String _title;
  String _description;
  String _nextRoute;
  RouteArgs _nextRouteArgs;
  bool _skipEnabled;

  void _showPermission() {
    // TODO: Show Permission
  }

  void _skipPermission() => navigateAndReplace(
      context: context, routeName: _nextRoute, arguments: _nextRouteArgs);

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    // Get Arguments
    final PermissionArgs args = ModalRoute.of(context).settings.arguments;
    _image = args.image;
    _title = args.title;
    _description = args.description;
    _nextRoute = args.nextRoute;
    _nextRouteArgs = args.nextRouteArgs;
    _skipEnabled = args.skipEnabled ?? false;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: _deviceHeight * .07,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("$PERMISSION_IMAGES_FOLDER$_image"),
                minRadius: _deviceWidth * .20,
                maxRadius: _deviceWidth * .35,
              ),
              SizedBox(
                height: _deviceHeight * .06,
              ),
              Text(
                _title,
                style: GoogleFonts.saralaTextTheme().display4.copyWith(
                    fontSize: 27.0,
                    letterSpacing: 1.35,
                    fontWeight: FontWeight.bold),
              ),
              Text(_description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.saralaTextTheme()
                      .display1
                      .copyWith(fontSize: 17.0, fontWeight: FontWeight.w400)),
              SizedBox(
                height: _deviceHeight * .07,
              ),
              Container(
                width: _deviceWidth * .37,
                height: 50.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FlatButton(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ALLOW",
                          style: GoogleFonts.saralaTextTheme()
                              .display1
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      color: AppColors.oylexPrimary.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      onPressed: _showPermission,
                    ),
                    Positioned(
                      right: 16.0,
                      top: 1.0,
                      bottom: 1.0,
                      child: Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: AppColors.oylexPrimary.shade600,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 19.0,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.oylexPrimary.shade50,
                        blurRadius: 8.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ]),
              ),
              SizedBox(
                height: _deviceHeight * .03,
              ),
              Visibility(
                visible: _skipEnabled,
                child: FlatButton(
                  child: Text(
                    "SKIP",
                    style: GoogleFonts.saralaTextTheme().display1.copyWith(
                        color: Colors.black38,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400),
                  ),
                  color: Colors.transparent,
                  onPressed: _skipPermission,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
