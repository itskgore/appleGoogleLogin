import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text appbarTitle(String title) {
  return Text("$title", style: GoogleFonts.poppins(color: Colors.white));
}

SizedBox buildSizedBox(double height, double value) {
  return SizedBox(
    height: height * value,
  );
}

SizedBox buildSizedBoxWidth(double width, double value) {
  return SizedBox(
    width: width * value,
  );
}

double buildWidth(BuildContext context) => MediaQuery.of(context).size.width;

double buildHeight(BuildContext context) => MediaQuery.of(context).size.height;

AppBar buildAppBar(BuildContext context, title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.transparent,
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop()),
  );
}

void showSnack(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey) {
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    content: Text(
      stringList,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.red),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black87,
  ));
}

Future showCupertinoPop(Map<String, dynamic> success, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text(success['msg']),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

void showSnackSuccess(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey) {
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    content: Text(
      stringList,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.green),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black87,
  ));
}
