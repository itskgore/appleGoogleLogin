import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goalArchiver/functions/widgetFunctions.dart';
import 'package:goalArchiver/providers/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SampleScreens extends StatefulWidget {
  SampleScreens({Key key}) : super(key: key);

  @override
  _SampleScreensState createState() => _SampleScreensState();
}

class _SampleScreensState extends State<SampleScreens> {
  void onGoogleSignIn(BuildContext context) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPageWidget(),
    );
  }
}

class LoginPageWidget extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  @override
  void initState() {
    super.initState();

    // initApp();
    isAppleLogin();
  }

  Future<void> isAppleLogin() async {
    if (Platform.isIOS) {
      final auth = Provider.of<Auth>(context, listen: false);
      auth.supportsAppleSignIn = await AppleSignIn.isAvailable();
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<Auth>(context, listen: false);
      final user = await authService
          .userAppleLogin(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<Auth>(
      builder: (con, auth, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(50),
                child: Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          auth.googleLoginTap();
                        },
                        color: Colors.blueAccent,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.account_circle, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Login with Google',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ))))),
            Consumer<Auth>(
              // future: isAppleLogin(),
              builder: (con, auth, _) => !auth.supportsAppleSignIn
                  ? Container()
                  : Container(
                      height: buildHeight(context) / 15,
                      width: buildWidth(context) / 1.5,
                      child: AppleSignInButton(
                        style: ButtonStyle.black,
                        type: ButtonType.continueButton,
                        onPressed: () {
                          // initiateSignInWithApple();
                          _signInWithApple(context);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
