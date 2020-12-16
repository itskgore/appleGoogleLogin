import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goalArchiver/providers/auth.dart';
import 'package:provider/provider.dart';

class WelcomeUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Consumer<Auth>(
          builder: (con, auth, _) => Container(
              color: Colors.white,
              padding: EdgeInsets.all(50),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                          child: auth.user.photoURL.isNotEmpty
                              ? Image.network(auth.user.photoURL,
                                  width: 100, height: 100, fit: BoxFit.cover)
                              : Image.asset("assets/images/exaltareLogo.png")),
                      SizedBox(height: 20),
                      Text('Welcome,', textAlign: TextAlign.center),
                      Text(auth.user.displayName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(height: 20),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            // _googleSignIn.signOut();
                            // Navigator.pop(context, false);
                            auth.googleLogout();
                          },
                          color: Colors.redAccent,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.exit_to_app, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text('Log out of Google',
                                      style: TextStyle(color: Colors.white))
                                ],
                              )))
                    ],
                  ))),
        ));
  }
}
