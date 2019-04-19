import 'dart:convert';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/branch.dart' as _branch;

class ScreenUserSelectBranch extends StatefulWidget {
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenUserSelectBranch> {
  List<_branch.Branch> _itemsBranch=[];
  String BranchName,BranchID;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Widget _buildBranchList() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black, fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

    return FutureBuilder<List<_branch.Branch>>(
        future: callDataBrnach(),
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
          _itemsBranch = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(
                left: 4.0, right: 4.0, top: 4.0, bottom: 32.0),
            child: ListView.builder(
              itemCount: _itemsBranch.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context,_itemsBranch[index].BranchID+","+_itemsBranch[index].BranchName);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingLabel,
                                        child: Text(_itemsBranch[index].BranchName,
                                          style: textInputStyleTitle,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            leading: Text((index+1).toString()+'.',style: textInputStyleTitle,),
                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                        )
                    ),
                  ),
                );
              },
            ),
          );
        }
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
        title: Text('เลือกสาขาวิชา',style: textStyleAppbar),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context,"back");
          },
        ),
      ),
      body: Container(
        child: _buildBranchList(),
      ),
    );
  }
  Future<List<_branch.Branch>> callDataBrnach() async {
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