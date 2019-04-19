import 'dart:convert';
import 'dart:typed_data';
import 'package:app_durable_articles/admin/screen_edit_karupan.dart';
import 'package:app_durable_articles/admin/screen_edit_user.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/karupan.dart' as _karupan;

class ScreenManageKarupan extends StatefulWidget {
  List<_karupan.Karupan> ItemKarupan;
  int Index;
  ScreenManageKarupan({
    Key key,
    @required this.ItemKarupan,
    @required this.Index,
  }) : super(key: key);

  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenManageKarupan> {

  String KarupanID;
  String Year;
  String PID;
  String PName;
  String Department;
  String Expired;
  String Build;
  String FloorNum;
  String Room;
  String Detail;
  String CheckStatusName;
  String Local;
  String BranchName;
  Uint8List bytes;
  @override
  void initState() {
    super.initState();

    KarupanID=widget.ItemKarupan[widget.Index].KarupanID;
    Year=widget.ItemKarupan[widget.Index].Year;
    PID = widget.ItemKarupan[widget.Index].PID;
    PName = widget.ItemKarupan[widget.Index].PName;
    Department = widget.ItemKarupan[widget.Index].Department;
    Expired = widget.ItemKarupan[widget.Index].Expired;
    Build = widget.ItemKarupan[widget.Index].Build;
    FloorNum = widget.ItemKarupan[widget.Index].FloorNum;

    Room = widget.ItemKarupan[widget.Index].Room;
    Detail = widget.ItemKarupan[widget.Index].Detail;
    CheckStatusName = widget.ItemKarupan[widget.Index].CheckStatusName;
    Local = widget.ItemKarupan[widget.Index].Local;
    BranchName=widget.ItemKarupan[widget.Index].BranchName;
    //bytes= base64Decode(widget.ItemKarupan[widget.Index].ImageFile);
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

    TextStyle textInputStyle = TextStyle(
        fontSize: 18.0, color: Colors.grey[500]);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 8.0, bottom: 8.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
/*
    if (widget.ItemKarupan[widget.Index].ImageFile == null)
      return new Container();
    Uint8List bytes = base64Decode(widget.ItemKarupan[widget.Index].ImageFile);*/
    //Data
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: new BoxDecoration(
                /*image: DecorationImage(
                  image: new AssetImage(
                      'assets/images/box_empty.png'),
                  fit: BoxFit.fill,
                ),*/
                shape: BoxShape.rectangle,
              ),
              child: new Image.network("http://kurupan.tech/"+widget.ItemKarupan[widget.Index].ImageFile,fit: BoxFit.contain),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24.0),
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
                                  child: Text(
                                    "ปีงบประมาณ", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Year, style: textInputStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    "ชื่อหน่วยงาน", style: textLabelStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    Department, style: textInputStyle,),
                                ),

                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "หมายเลขครุภัณฑ์", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(PID, style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ชื่อครุภัณฑ์", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(PName, style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("จำนวน", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Expired, style: textInputStyle,),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "อาคาร", style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        Build, style: textInputStyle,),
                                    ),
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "ชั้น", style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        FloorNum, style: textInputStyle,),
                                    ),
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "ห้อง", style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(Room, style: textInputStyle,),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "รายละเอียดครุภัณฑ์",
                                    style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Detail, style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("สถานะ", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    CheckStatusName, style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "สถานที่เก็บ", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Local, style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "สาขาวิชา", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    BranchName, style: textInputStyle,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  _navigateEditUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenEditKarupan(
        ItemKarupan: widget.ItemKarupan,
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
                _showDialogDelete(context,"ต้องการลบข้อมูลครุภัณฑ์นี้",KarupanID);
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
  Future<http.Response> callDeleteUser(karupanID) async {
    final paramDic = {
      "KarupanID": karupanID,
    };
    final response = await http.post(
        Server().IPAddress + "/DeleteKarupan.php",
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