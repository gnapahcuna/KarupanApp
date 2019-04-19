import 'dart:convert';
import 'package:app_durable_articles/admin/screen_user_select_branch.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/user.dart' as _users;

class ScreenEditUser extends StatefulWidget {
  List<_users.Users> ItemUser;
  int Index;
  ScreenEditUser({
    Key key,
    @required this.ItemUser,
    @required this.Index,
  }) : super(key: key);
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenEditUser> {

  final FocusNode myFocusNodeUsername = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeFirstname = FocusNode();
  final FocusNode myFocusNodeLastname= FocusNode();
  final FocusNode myFocusNodePosition= FocusNode();

  TextEditingController UsernameController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController FirstnameController = new TextEditingController();
  TextEditingController LastnameController = new TextEditingController();
  TextEditingController PositoinController = new TextEditingController();

  String _dropdownTitlename="นาย";
  String _dropdownUserTypeName="ผู้ใช้งานทั่วไป";

  List<String> itemsUserType=['ผู้เชี่ยวชาญ','ผู้ใช้งานทั่วไป'];
  List<String> itemsTitleName = ['นาย','นาง','นางสาว'];

  bool _obscureTextLogin = true;

  String branchID,branchName;


  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData()async{
    setState(() {
      //_dropdownTitlename=widget.ItemUser[widget.Index].TitleName;
      FirstnameController.text=widget.ItemUser[widget.Index].FirstName;
      LastnameController.text=widget.ItemUser[widget.Index].LastName;
      PositoinController.text=widget.ItemUser[widget.Index].Position;
      UsernameController.text=widget.ItemUser[widget.Index].Username;
      PasswordController.text=widget.ItemUser[widget.Index].Password;
      //_dropdownUserTypeName=widget.ItemUser[widget.Index].UserTypeName;
      branchID=widget.ItemUser[widget.Index].BranchID;
      branchName=widget.ItemUser[widget.Index].BranchName;
    });

    //print(_dropdownTitlename);
    //print(_dropdownUserTypeName);
  }

  @override
  void dispose() {
    super.dispose();
    UsernameController.dispose();
    PasswordController.dispose();
    FirstnameController.dispose();
    LastnameController.dispose();
    PositoinController.dispose();
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

  void _showAlertDialog(text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog(text);
      },
    );
  }
  _navigateSelectBrnach(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenUserSelectBranch(
      )),
    );
    if(result.toString()!="back") {
      setState(() {
        List splits = result.toString().split(",");
        branchID = splits[0];
        branchName = splits[1];
      });
    }else{
      setState(() {
        branchName=widget.ItemUser[widget.Index].BranchName;
        branchID=widget.ItemUser[widget.Index].BranchID;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color _color = Color(0xff556080);
    Color _colorAppbar = Colors.white;
    Color _color1 = Colors.grey[500];
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _color);
    TextStyle textStyleHint = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _color1);
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 20.0,
        color: _colorAppbar);
    TextStyle textStyleTabbar = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _colorAppbar);
    var size = MediaQuery
        .of(context)
        .size;

    final makeBottom = new Container(
      //margin: EdgeInsets.only(bottom: 18.0),
      height: 55.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0)
          )
      ),
      child:RaisedButton(
        color: Colors.grey[500],
        onPressed: () {
          _navigateSelectBrnach(context);
        },
        child: Center(
          child: Text(
              'เลือกสาขาวิชา',
              style: textStyleTabbar
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text('บันทึก',style: textStyleAppbar,),
            onPressed: (){
               String titlename =_dropdownTitlename;
               String firstname = FirstnameController.text;
               String lastname = LastnameController.text;
               String position = PositoinController.text;
               String username = UsernameController.text;
               String password = PasswordController.text;
               int usertype;
               if(_dropdownUserTypeName.endsWith("ผู้เชี่ยวชาญ")){
                 usertype=2;
               }else{
                 usertype=3;
               }
               if(firstname.isEmpty||lastname.isEmpty||position.isEmpty||username.isEmpty||password.isEmpty){
                 _showAlertDialog('กรุณากรอกข้อมูลครบทุกช่อง!');
               }else {
                 sendData(
                   widget.ItemUser[widget.Index].UserID,
                     titlename,
                     firstname,
                     lastname,
                     position,
                     username,
                     password,
                     usertype,
                   context
                 );
               }
            },
          )
        ],
        title: Text('เแก้ไขผู้ใช้งาน',style: textStyleAppbar),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: (size.width*80)/100,
                  //padding: paddingInputBox,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _dropdownTitlename,
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownTitlename = newValue;
                        });
                      },
                      items: itemsTitleName
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeFirstname,
                    controller: FirstnameController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ชื่อ",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  child: TextField(
                    focusNode: myFocusNodeLastname,
                    controller: LastnameController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "นามสกุล",
                      labelStyle: textStyleHint,

                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  child: TextField(
                    focusNode: myFocusNodePosition,
                    controller: PositoinController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ตำแหน่ง",
                      labelStyle: textStyleHint,

                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  child: TextField(
                    focusNode: myFocusNodeUsername,
                    controller: UsernameController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Username",
                      labelStyle: textStyleHint,

                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  child: TextField(
                    focusNode: myFocusNodePassword,
                    controller: PasswordController,
                    obscureText: _obscureTextLogin,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  //padding: paddingInputBox,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _dropdownUserTypeName,
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownUserTypeName = newValue;
                        });
                      },
                      items: itemsUserType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  width: (size.width*80)/100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                    width: (size.width*80)/100,
                    padding: EdgeInsets.only(top: 22.0,bottom: 12.0),
                    child: Center(
                      child: Text('สาขาวิชา : ' + branchName,style: textStyle,),
                    )
                ),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: makeBottom,
    );
  }
  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
  Future<http.Response> callAddUser(userID,title, firstname,lastname,position,username,password,usertype) async {
    final paramDic = {
      "UserID": userID,
      "TitleName": title,
      "FirstName": firstname,
      "LastName": lastname,
      "Position": position,
      "Username": username,
      "Password": password,
      "UserType": usertype.toString(),
      "BranchID": branchID,
    };
    final addUser = await http.post(
      Server().IPAddress + "/EditUser.php", // change with your API
      body: paramDic,
    );
    return addUser;
  }

  void sendData(userID,title, firstname,lastname,position,username,password,usertype,mContext)async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color(0xff556080)),),);
        });
    await onLoadAction(
        userID,title, firstname,lastname,position,username,password,usertype,mContext
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
  Future<bool> onLoadAction(
      userID,title, firstname,lastname,position,username,password,usertype,mContext
      ) async {
    await  callAddUser(userID,title, firstname, lastname, position, username, password, usertype);
    return true;
  }
}