import 'dart:convert';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenAddBranch extends StatefulWidget {
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenAddBranch> {

  final FocusNode myFocusNodeBranchName = FocusNode();
  TextEditingController BranchNameController = new TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeBranchName.dispose();
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
          FlatButton(
            child: Text('บันทึก',style: textStyleAppbar,),
            onPressed: (){
               String branch = BranchNameController.text;
               if(branch.isEmpty){
                 _showAlertDialog('กรุณากรอกข้อมูลครบทุกช่อง!');
               }else {
                 sendData(
                     branch,
                   context
                 );
               }
            },
          )
        ],
        title: Text('เพิ่มสาขาวิชา',style: textStyleAppbar),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: (size.width*80)/100,
                //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                child: TextField(
                  focusNode: myFocusNodeBranchName,
                  controller: BranchNameController,
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "ชื่อสาขาวิชา",
                    labelStyle: textStyleHint,
                  ),
                ),
              ),
              Container(
                width: (size.width*80)/100,
                height: 1.0,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> callAddUser(branch) async {
    final paramDic = {
      "BranchName": branch,
    };
    final addUser = await http.post(
      Server().IPAddress + "/AddBranch.php", // change with your API
      body: paramDic,
    );
    return addUser;
  }

  void sendData(branch,mContext)async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color(0xff556080)),),);
        });
    await onLoadAction(
        branch,mContext
    );
    Navigator.pop(context);
    Navigator.pop(context);

  }
  Future<bool> onLoadAction(
      branch,mContext
      ) async {
    await callAddUser(branch);
    return true;
  }
}