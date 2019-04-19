import 'package:flutter/material.dart';

class FragmentHome extends StatefulWidget {
  State createState() {
    return FragmentHomeState();
  }
}
class FragmentHomeState extends State<FragmentHome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    Color _color = Color(0xff556080);
    Color _colorAppbar = Colors.white;
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 32.0,
        color: _color);
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _colorAppbar);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width/1.2,
          height: size.width/1.2,
          child: new Image(
              fit: BoxFit.contain,
              image: new AssetImage(
                  'assets/images/box.png')),
        ),
      ),
    );
  }
}