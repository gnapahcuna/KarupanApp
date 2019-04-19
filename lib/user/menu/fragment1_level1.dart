import 'dart:convert';

import 'package:app_durable_articles/server/server.dart';
import 'package:app_durable_articles/user/menu/fragment1_level2.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/karupan.dart' as _karupan;
import 'package:http/http.dart' as http;

class Fragment1Level1 extends StatefulWidget {
  String BranchID;
  String BranchName;
  Fragment1Level1({
    Key key,
    @required this.BranchID,
    @required this.BranchName,
  }) : super(key: key);
  State createState() {
    return Fragment1Level1State();
  }
}
class Fragment1Level1State extends State<Fragment1Level1> {

  List<_karupan.Karupan> _itemsKurapan=[];

  buildDataContent(index) {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black);
    return ListTile(
      title: Text("ปีงบประมาณ พ.ศ."+_itemsKurapan[index].Year,
        style: textInputStyleTitle,),
      trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 18,),
    );
  }

  Widget _buildList() {
    Color labelColor = Color(0xff087de1);
    TextStyle textExpandStyle = TextStyle(fontSize: 16.0, color: labelColor);
    return FutureBuilder<List<_karupan.Karupan>>(
        future: callDataKurapan(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            // Shows progress indicator until the data is load.
            return new MaterialApp(
              debugShowCheckedModeBanner: false,
              home: new Scaffold(
                //backgroundColor: cl_back,
                body: Center(
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color(0xff556080)),),
                ),
              ),
            );
          _itemsKurapan = snapshot.data;
          return _itemsKurapan.length>0?ListView.builder(
            itemCount: _itemsKurapan.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fragment1Level2(BranchID: widget.BranchID,Years: _itemsKurapan[index].Year,)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    padding: EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        left: BorderSide(color: Colors.grey[300], width: 1.0),
                        right: BorderSide(color: Colors.grey[300], width: 1.0),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0)
                      ),
                    ),
                    child: buildDataContent(index),
                  ),
                ),
              );
            },
          ):Center(child: Text("ไม่มีข้อมูลครุภัณฑ์สำหรับสาขาวิชานี้",style: TextStyle(fontFamily: "Kanit",fontSize: 20.0),),);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    Color _colorAppbar = Colors.white;
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 20.0,
        color: _colorAppbar);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.BranchName,style: textStyleAppbar,),
      ),
      body: _buildList()
    );
  }
  Future<List<_karupan.Karupan>> callDataKurapan() async {
    final paramDic = {
      "BranchID": widget.BranchID,
    };
    final response = await http.post(
      Server().IPAddress + "/GetYear.php",
      body: paramDic,
    );
    if (response.statusCode == 200) {
      print(response.body);
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new _karupan.Karupan.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}
class Menu {
  String name;
  String key;
  Menu({this.name, this.key});
}