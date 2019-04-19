import 'package:app_durable_articles/user/home_page.dart';
import 'package:app_durable_articles/admin/home_page_admin.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:app_durable_articles/user/model/user.dart' as _users;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  State createState() {
    return LoginPageState();
  }
}
class LoginPageState extends State<LoginPage> {
  final FocusNode myFocusNodeUsername = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();

  TextEditingController UsernameController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  ProgressHUD _progressHUD;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    //UsernameController.text="pang";
    //PasswordController.text="1234";
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
    );
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeUsername.dispose();
    myFocusNodePassword.dispose();
  }

  CupertinoAlertDialog _createCupertinoCancelDeleteDialog(text) {
    Color _color = Color(0xff556080);
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: "Kanit");
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontFamily: "Kanit");
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Text(text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ตกลง', style: ButtonAcceptStyle)),
        ]
    );
  }
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }
  void _showAlertDialog(text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog(text);
      },
    );
  }

  _navigateLogin(context, username, password) async {
    callLogin(username, password).then((s) async {
      List<_users.Users> users = s;
      if (s.length != 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xff556080)),),);
            });
        await onLoadAction();
        Navigator.pop(context);
      users.forEach((user){
        if(int.parse(user.UserTypeID)==1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageAdmin()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(itemsUser: users,)),
          );
        }
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _color = Color(0xff556080);
    Color _color1 = Colors.grey[300];
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _color);
    TextStyle textStyleHint = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _color1);
    TextStyle textStyleLogin = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: Colors.white);
    var size = MediaQuery
        .of(context)
        .size;
    return new WillPopScope(
        onWillPop: () async {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }, child: Scaffold(
        body: SingleChildScrollView(
          child: Align(
              alignment: Alignment.center,
              child: Container(
                width: (size.width * 80) / 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        //top: 65.0, left: 38.0, right: 38.0, bottom: 35.0),
                          top: (size.height * 15) / 100,
                          left: 0.0,
                          right: 0.0,
                          bottom: (size.height * 3) / 100),
                      child: new Image(
                          fit: BoxFit.cover,
                          image: new AssetImage(
                              'assets/images/logo.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                      child: TextField(
                        focusNode: myFocusNodeUsername,
                        controller: UsernameController,
                        keyboardType: TextInputType.text,
                        style: textStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.account_circle, color: _color, size: 32.0,),
                          labelText: "Username",
                          labelStyle: textStyleHint,
                        ),
                      ),
                    ),
                    Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      child: TextField(
                        focusNode: myFocusNodePassword,
                        controller: PasswordController,
                        obscureText: _obscureTextLogin,
                        keyboardType: TextInputType.text,
                        style: textStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.vpn_key, color: _color, size: 32.0,),
                          labelText: "Password",
                          labelStyle: textStyleHint,
                          suffixIcon: GestureDetector(
                            onTap: _toggleLogin,
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 28.0,
                              color: _color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: (size.height * 10) / 100,),
                      child: Card(
                          color: _color,
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: _color, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                String username = UsernameController.text;
                                String password = PasswordController.text;
                                if (username.isEmpty || password.isEmpty) {
                                  _showAlertDialog("กรุณากรอกข้อมูลให้ครับ!");
                                } else {
                                  _navigateLogin(context, username, password);
                                }
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("Login", style: textStyleLogin,),),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
    ),
    );
  }
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  Future<List<_users.Users>> callLogin(username, password) async {
    final paramDic = {
      "Username": username,
      "Password": password,
    };
    final response = await http.post(
      Server().IPAddress + "/UserLogin.php",
      body: paramDic,
    );
    if (response.statusCode == 200) {
      List responseJson=[];
      if(response.body.endsWith("NotUser")){
        _showAlertDialog("Username หรือ Password ไม่ถูกต้อง!");
      }else {
        responseJson = json.decode(response.body);
      }
      return responseJson.map((m) => new _users.Users.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}