import 'dart:convert';
import 'package:app_durable_articles/admin/screen_edit_user.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/user.dart' as _users;

class ScreenManageUser extends StatefulWidget {
  List<_users.Users> ItemUser;
  int Index;
  ScreenManageUser({
    Key key,
    @required this.ItemUser,
    @required this.Index,
  }) : super(key: key);

  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenManageUser> {

  String userID;
  String name;
  String position;
  String username;
  String password;
  String usertype;
  String branch;

  @override
  void initState() {
    super.initState();

    userID=widget.ItemUser[widget.Index].UserID;
    name = widget.ItemUser[widget.Index].TitleName + widget.ItemUser[widget.Index].FirstName + " " + widget.ItemUser[widget.Index].LastName;
    position = widget.ItemUser[widget.Index].Position;
    username = widget.ItemUser[widget.Index].Username;
    password = widget.ItemUser[widget.Index].Password;
    usertype = widget.ItemUser[widget.Index].UserTypeName;
    branch = widget.ItemUser[widget.Index].BranchName;
  }

  @override
  void dispose() {
    super.dispose();
  }

  CupertinoAlertDialog _createCupertinoDelete(mContext,title,userID) {
    Color _color = Color(0xff556080);
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: "Kanit");
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontFamily: "Kanit");
    TextStyle ButtonCancelStyle = TextStyle(
        color: _color, fontSize: 18.0, fontFamily: "Kanit");
    return new CupertinoAlertDialog(
      //title: new Text("ยืนยัน?", style: TextStyle(fontFamily: 'Poppins'),),
        content: new Text(title,
            style: TitleStyle),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                //call delete
                callDeleteUser(userID).then((value){
                  Navigator.pop(mContext);
                });
              },
              child: new Text(
                  'ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showDialogDelete(mContext,title,userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDelete(mContext,title,userID);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    Color labelColor = Color(0xff556080);

    TextStyle textInputStyle = TextStyle(fontSize: 18.0, color: Colors.grey[500]);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox =  EdgeInsets.only(top: 8.0, bottom: 8.0);
    EdgeInsets paddingLabel =  EdgeInsets.only(top: 12.0);

    //Data
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Container(
                width: Width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อ-นามสกุล",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(name,style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("ตำแหน่ง",style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(position.isEmpty?'-':position,style: textInputStyle,),
                      ),

                      Container(
                        padding: paddingLabel,
                        child: Text("Username",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(username,style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("Password",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(password,style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ประเภท User",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(usertype,style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("สาขาวิชา",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(branch,style: textInputStyle,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  _navigateEditUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenEditUser(
        ItemUser: widget.ItemUser,
        Index: widget.Index,
      )),
    );
    Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu>(
            elevation: 0.0,
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'จัดการข้อมูลผู้ใช้',
            onSelected: (CustomPopupMenu choice){
              if(choice.title.endsWith("แก้ไข")){
                _navigateEditUser(context);
              }else{
                _showDialogDelete(context,"ต้องการลบข้อมูลผู้ใช้นี้",userID);
              }
            },
            itemBuilder: (BuildContext context) {
              return choices.map((
                  CustomPopupMenu choice) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          )
        ],
        title: Text('จัดการผู้ใช้งาน',style: textStyleAppbar),
        centerTitle: true,
      ),
      body: Center(
        child: _buildContent(context),
      ),
    );
  }
  Future<http.Response> callDeleteUser(userID) async {
    final paramDic = {
      "UserID": userID,
    };
    final response = await http.post(
        Server().IPAddress + "/DeleteUser.php",
        body: paramDic
    );
    return response;
  }
}
List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'แก้ไข', icon: Icons.edit),
  CustomPopupMenu(title: 'ลบ', icon: Icons.delete),
];
class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});

  String title;
  IconData icon;
}