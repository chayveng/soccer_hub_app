import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/routs.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';
import 'package:project_app/ui/screens/testScreen/TestScreen.dart';
import 'core/services/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  Widget screen = LoginScreen();
  if (await AuthService.isLogin() == true) {
    screen = MainScreen();
  }
  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  // final darkTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.black,
  //   brightness: Brightness.dark,
  //   backgroundColor: const Color(0xFF212121),
  //   accentColor: Colors.white,
  //   accentIconTheme: IconThemeData(color: Colors.black),
  //   dividerColor: Colors.black12,
  // );
  //
  // final lightTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.white,
  //   brightness: Brightness.light,
  //   backgroundColor: const Color(0xFFE5E5E5),
  //   accentColor: Colors.black,
  //   accentIconTheme: IconThemeData(color: Colors.white),
  //   dividerColor: Colors.white54,
  // );

  MyApp({
    Key key,
    @required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: UiFont,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: greenPrimaryColor),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 22,
              fontFamily: UiFont,
              fontWeight: FontWeight.bold,
              color: greenPrimaryColor,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          color: creamPrimaryColor,
        ),
      ),
      title: 'Flutter Demo',
      routes: routes,
      // home: screen,
      // home: FirstScreen(),
      // home: TestScreen(),
      home: MainScreen(),
    );
  }
}
