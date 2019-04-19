import 'dart:async';
import 'package:app_durable_articles/admin/home_page_admin.dart';
import 'package:app_durable_articles/user/home_page.dart';
import 'package:app_durable_articles/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kurupan',
      theme: ThemeData(
        primaryColor: Color(0xff556080),
      ),
      home: SplashScreen(),
      //home: TestFirebase(),
      routes: <String, WidgetBuilder>{
        //intent เกี่ยวข้อง
        '/Login': (BuildContext context) => new LoginPage(),
        '/Home': (BuildContext context) => new HomePage(),
        '/HomeAdd': (BuildContext context) => new HomePageAdmin(),
      },
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  SharedPreferences prefs;
  Animation animation;
  AnimationController animationController;
  int factcounter = 0;
  int colorcounter = 0;

  void navigationPage() async {
    //intent
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();

    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showfacts() {
    setState(() {
      /* dispfact = facts[factcounter];
      dispcolor = bgcolors[colorcounter];
      factcounter = factcounter < facts.length - 1 ? factcounter + 1 : 0;
      colorcounter = colorcounter < bgcolors.length - 1 ? colorcounter + 1 : 0;*/

      animationController.reset();
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
        child: new Center(
          child: new Opacity(
            opacity: animation.value * 1,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, animation.value * -50.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage(
                            'assets/images/splash_icon.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),),
        ),
      ),
    );
  }
}