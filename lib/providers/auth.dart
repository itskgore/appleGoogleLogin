import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goalArchiver/functions/preferences.dart';
import 'package:goalArchiver/models/userModel.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  // instances
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;
  User user;
  bool checkLoginLoading = true;
  bool isLoading = false;
  UserModel _userModel;
  Preferences _preferences;
  bool supportsAppleSignIn = false;
  //-

  // auth functions
  Future<void> getInstance() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  Future<void> checkIfUserIsSignedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userSignedIn = await _googleSignIn.isSignedIn();
    isUserSignedIn = userSignedIn;
    checkLoginLoading = false;
    if (isUserSignedIn) {
      user = _auth.currentUser;
      UserModel.fromJson({
        "id": "",
        "firstName": user.displayName,
        "lastName": "",
        "profilePicture": user.photoURL,
        "loginType": LoginType.google.toString(),
        "email": user.email
      });
    } else {}

    notifyListeners();
  }

  Future<void> googleLoginTap() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool userSignedIn = await _googleSignIn.isSignedIn();
    if (userSignedIn) {
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      isUserSignedIn = userSignedIn;

      sharedPreferences.setString("id", googleAuth.idToken.toString());

      UserModel.fromJson({
        "id": googleAuth.idToken.toString(),
        "firstName": user.displayName,
        "lastName": "",
        "profilePicture": user.photoURL,
        "loginType": LoginType.google.toString(),
        "email": user.email
      });

      notifyListeners();
    }
  }

  Future<User> userAppleLogin({List<Scope> scopes = const []}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _auth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(displayName: displayName);
        }
        sharedPreferences.setString("id", user.uid.toString());
        UserModel.fromJson({
          "id": user.uid.toString(),
          "firstName": user.displayName,
          "lastName": "",
          "profilePicture": user.photoURL,
          "loginType": LoginType.apple.toString(),
          "email": user.email
        });
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  triggerLoading(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<void> googleLogout() async {
    triggerLoading(true);
    final data = await _googleSignIn.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    triggerLoading(false);
  }
  //-
}
