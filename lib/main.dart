import 'package:flutter/material.dart';
import 'package:goalArchiver/providers/auth.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreen.dart';
import 'screens/sample.dart';
import 'screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<Auth>(
            builder: (con, auth, _) => FutureBuilder(
                future: auth.getInstance(),
                builder: (con, snap) => auth.checkLoginLoading
                    ? SplashScreen()
                    : auth.isUserSignedIn
                        ? WelcomeUserWidget()
                        : SampleScreens())),
      ),
    );
  }
}
