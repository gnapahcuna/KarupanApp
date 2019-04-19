import 'dart:convert';

import 'package:app_durable_articles/server/server.dart';
import 'package:app_durable_articles/user/menu/fragment1_level1.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/branch.dart' as _branch;
import 'package:http/http.dart' as http;

class Fragment1 extends StatefulWidget {
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<Fragment1> {

  List<_branch.Branch> itemsBranch=[];

  _navigateContent(context,branchID,branchName)async{
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Fragment1Level1(BranchID: branchID,BranchName: branchName,)),
    );
  }

  buildDataContent(index) {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black);
    return ListTile(
      title: Text(itemsBranch[index].BranchName,
        style: textInputStyleTitle,),
      trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 18,),
    );
  }

  Widget _buildList() {
    Color labelColor = Color(0xff087de1);
    TextStyle textExpandStyle = TextStyle(fontSize: 16.0, color: labelColor);
    return FutureBuilder<List<_branch.Branch>>(
        future: callDataBranch(),
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
          itemsBranch = snapshot.data;
          return ListView.builder(
            itemCount: itemsBranch.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  _navigateContent(context,itemsBranch[index].BranchID,itemsBranch[index].BranchName);
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
          );
        }
    );
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
      backgroundColor: Colors.grey[300],
      body: _buildList(),
    );
  }
  Future<List<_branch.Branch>> callDataBranch() async {
    final response = await http.post(
      Server().IPAddress + "/GetBranch.php",
    );
    if (response.statusCode == 200) {
      //print(response.body);
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new _branch.Branch.fromJson(m)).toList();
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