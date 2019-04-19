import 'dart:convert';

import 'package:app_durable_articles/server/server.dart';
import 'package:app_durable_articles/user/menu/fragment1_level3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/karupan.dart' as _karupan;
import 'package:http/http.dart' as http;

class Fragment2 extends StatefulWidget {
  State createState() {
    return Fragment2State();
  }
}
class Fragment2State extends State<Fragment2> {
  TextEditingController controllerUser = new TextEditingController();

  onSearchTextSubmit (String text) async {
    print(text);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color(0xff556080)),),);
        });
    await onLoadAction();
    Navigator.pop(context);
    callDataKurapan(text).then((item){
      if(item.length==0){
        _showAlertDialog("ไม่พบข้อมูลครุภัณฑ์");
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Fragment1Level3(ItemKarupan: item,Indexes: 0,)),
        );
      }
    });
    setState(() {});
  }
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
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
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 20.0,
        color: _color);
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _colorAppbar);
    TextStyle textStyleSearch = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: Colors.grey[400]);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Text('ค้นหาด้วยหมายเลขครุภัณฑ์',style: textStyle,),
            ),
            Container(
              //width: itemWidth,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: new Card(
                  elevation: 0.0,
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: new TextField(
                    style: textStyle,
                    controller: controllerUser,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: "ค้นหา",
                        hintStyle: textStyleSearch,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,size: 28,color: Colors.grey[400],)
                    ),
                    onSubmitted: onSearchTextSubmit,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  Future<List<_karupan.Karupan>> callDataKurapan(text) async {
    final paramDic = {
      "Search": text,
    };
    final response = await http.post(
      Server().IPAddress + "/SearchKarupan.php",
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