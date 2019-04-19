import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/karupan.dart' as _karupan;
class Fragment1Level3 extends StatefulWidget {
  List<_karupan.Karupan> ItemKarupan;
  int Indexes;
  Fragment1Level3({
    Key key,
    @required this.ItemKarupan,
    @required this.Indexes,
  }) : super(key: key);
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<Fragment1Level3> {

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
                child: new Image.network("http://kurupan.tech/"+widget.ItemKarupan[widget.Indexes].ImageFile,fit: BoxFit.contain),
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
                                  child: Text("ปีงบประมาณ",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Year,style: textInputStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text("ชื่อหน่วยงาน",style: textLabelStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(Department,style: textInputStyle,),
                                ),

                                Container(
                                  padding: paddingLabel,
                                  child: Text("หมายเลขครุภัณฑ์",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(PID,style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("ชื่อครุภัณฑ์",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(PName,style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("จำนวน",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Expired,style: textInputStyle,),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text("อาคาร",style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(Build,style: textInputStyle,),
                                    ),
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text("ชั้น",style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(FloorNum,style: textInputStyle,),
                                    ),
                                    Container(
                                      padding: paddingInputBox,
                                      child: Text("ห้อง",style: textLabelStyle,),
                                    ),
                                    Padding(
                                      padding: paddingInputBox,
                                      child: Text(Room,style: textInputStyle,),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("รายละเอียดครุภัณฑ์",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Detail,style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("สถานะ",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(CheckStatusName,style: textInputStyle,),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text("สถานที่เก็บ",style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(Local,style: textInputStyle,),
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
            )
          ],
        )
    );
  }

  @override
  void initState() {
    super.initState();
    int index=widget.Indexes;
    KarupanID=widget.ItemKarupan[index].KarupanID;
    Year=widget.ItemKarupan[index].Year;
    PID = widget.ItemKarupan[index].PID;
    PName = widget.ItemKarupan[index].PName;
    Department = widget.ItemKarupan[index].Department;
    Expired = widget.ItemKarupan[index].Expired;
    Build = widget.ItemKarupan[index].Build;
    FloorNum = widget.ItemKarupan[index].FloorNum;
    Room = widget.ItemKarupan[index].Room;
    Detail = widget.ItemKarupan[index].Detail;
    CheckStatusName = widget.ItemKarupan[index].CheckStatusName;
    Local = widget.ItemKarupan[index].Local;
  }

  @override
  Widget build(BuildContext context) {
    Color _color = Color(0xff556080);
    Color _colorAppbar = Colors.white;
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: _color);
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _colorAppbar);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("รายละเอียดครรุภัณฑ์",style: textStyleAppbar,),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: _buildContent(context),
      ),
    );
  }
}
class Menu {
  String name;
  String key;
  Menu({this.name, this.key});
}