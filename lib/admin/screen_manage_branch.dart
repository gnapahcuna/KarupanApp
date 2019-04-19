import 'dart:convert';
import 'package:app_durable_articles/admin/screen_edit_branch.dart';
import 'package:app_durable_articles/admin/screen_edit_user.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/branch.dart' as _branch;

class ScreenManageBranch extends StatefulWidget {
  List<_branch.Branch> ItemBranch;
  int Index;
  ScreenManageBranch({
    Key key,
    @required this.ItemBranch,
    @required this.Index,
  }) : super(key: key);

  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenManageBranch> {

  String branchID;
  String branchName;

  @override
  void initState() {
    super.initState();
    branchID=widget.ItemBranch[widget.Index].BranchID;
    branchName = widget.ItemBranch[widget.Index].BranchName;
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
                callDeleteBranch(branchID).then((value){
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
                        child: Text("รหัสสาขาวิชา",style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(branchID,style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("ชื่อสาขาวิชา",style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(branchName,style: textInputStyle,),
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

  _navigateEditBranch(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenEditBranch(
        ItemBranch: widget.ItemBranch,
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
            tooltip: 'จัดการข้อมูลสาขา',
            onSelected: (CustomPopupMenu choice){
              if(choice.title.endsWith("แก้ไข")){
                _navigateEditBranch(context);
              }else{
                _showDialogDelete(context,"ต้องการลบข้อมูลสาขาวิชานี้",branchID);
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
      body: Container(
        padding: EdgeInsets.only(top: 12.0),
        child: _buildContent(context),
      ),
    );
  }
  Future<http.Response> callDeleteBranch(branhID) async {
    final paramDic = {
      "BranchID": branhID,
    };
    final response = await http.post(
        Server().IPAddress + "/DeleteBranch.php",
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