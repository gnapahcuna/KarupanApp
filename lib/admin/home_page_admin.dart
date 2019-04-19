import 'dart:convert';

import 'package:app_durable_articles/admin/screen_add_branch.dart';
import 'package:app_durable_articles/admin/screen_add_karupan.dart';
import 'package:app_durable_articles/admin/screen_add_user.dart';
import 'package:app_durable_articles/admin/screen_edit_branch.dart';
import 'package:app_durable_articles/admin/screen_manage_branch.dart';
import 'package:app_durable_articles/admin/screen_manage_karupan.dart';
import 'package:app_durable_articles/admin/screen_manage_user.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/admin/model/user.dart' as _users;
import 'package:app_durable_articles/admin/model/branch.dart' as _branch;
import 'package:app_durable_articles/admin/model/karupan.dart' as _karupan;
import 'package:http/http.dart' as http;
class HomePageAdmin extends StatefulWidget {
  /*List<_users.Users> itemsUser;
  HomePageAdmin({
    Key key,
    @required this.itemsUser,
  }) : super(key: key);*/
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<HomePageAdmin> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerKarupan = new TextEditingController();
  TextEditingController controllerBranch = new TextEditingController();
  List<_users.Users> _searchResultUser = [];
  List<_users.Users> _itemsUser = [];

  List<_branch.Branch> _searchResultBranch = [];
  List<_branch.Branch> _itemsBranch = [];

  List<_karupan.Karupan> _searchResultKarupan = [];
  List<_karupan.Karupan> _itemsKarupan = [];

  CupertinoAlertDialog _createCupertinoAlertDialog(mContext) {
    Color _color = Color(0xff556080);
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: "Kanit");
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontFamily: "Kanit");
    TextStyle ButtonCancelStyle = TextStyle(
        color: _color, fontSize: 18.0, fontFamily: "Kanit");
    return new CupertinoAlertDialog(
      //title: new Text("ยืนยัน?", style: TextStyle(fontFamily: 'Poppins'),),
        content: new Text("ต้องการออกจากระบบ.",
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
                Navigator.of(mContext).pushReplacementNamed('/Login');
              },
              child: new Text(
                  'ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showDialogLogOut(mContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoAlertDialog(mContext);
      },
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
        fontSize: 20.0,
        color: _colorAppbar);
    TextStyle textStyleTabbar = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _colorAppbar);
    return new WillPopScope(
        onWillPop: () async {
          _showDialogLogOut(context);
    }, child:DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                _showDialogLogOut(context);
              },
              icon: Icon(Icons.exit_to_app,color: _colorAppbar,),
            )
          ],
          bottom: TabBar(
            labelStyle: textStyleTabbar,
            tabs: [
              Tab(text: "ผู้ใช้งาน"),
              Tab(text: "ครุภัณฑ์"),
              Tab(text: "สาขาวิชา"),
            ],
          ),
          title: Text('ส่วนจัดการสำหรับผู้ดูแลระบบ',style: textStyleAppbar),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            _buildContentTab1(),
            _buildContentTab2(),
            _buildContentTab3()
          ],
        ),
      ),
    ),
    );
  }
  //*****************************tab1****************************
  onSearchTextChangedUser(String text) async {
    print(text);
    _searchResultUser.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _itemsUser.forEach((userDetail) {
      if (userDetail.FirstName.contains(text) ||
          userDetail.LastName.contains(text)||
          userDetail.BranchName.contains(text))
        _searchResultUser.add(userDetail);
    });
    setState(() {});
  }
  Widget _buildSearchUserResults() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black,fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: "Kanit");
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelPreview,fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      child: ListView.builder(
        itemCount: _searchResultUser.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child:ListTile(
                    leading: Text((index+1).toString()+'.',style: textInputStyleTitle,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenManageUser(
                        ItemUser: _searchResultUser,
                        Index: index,
                      )),
                    );
                  },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingLabel,
                                child: Text(_searchResultUser[index].TitleName +
                                    _searchResultUser[index].FirstName + ' ' +
                                    _searchResultUser[index].LastName,
                                  style: textInputStyleTitle,),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text('ตำแหน่ง '+
                            _searchResultUser[index].Position,
                            style: textInputStyleSub,),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text('สาขาวิชา '+
                            _searchResultUser[index].BranchName,
                            style: textInputStyleSub,),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildUsersList() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black, fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

    return FutureBuilder<List<_users.Users>>(
        future: callDataUser(),
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
          _itemsUser = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(
                left: 4.0, right: 4.0, top: 4.0, bottom: 32.0),
            child: ListView.builder(
              itemCount: _itemsUser.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
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
                            leading: Text((index+1).toString()+'.',style: textInputStyleTitle,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScreenManageUser(
                                ItemUser: _itemsUser,
                                Index: index,
                              )),
                            );
                          },
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Text(_itemsUser[index].TitleName +
                                          _itemsUser[index].FirstName + ' ' +
                                          _itemsUser[index].LastName,
                                        style: textInputStyleTitle,),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text('ตำแหน่ง '+
                                    _itemsUser[index].Position,
                                  style: textInputStyleSub,),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text('สาขาวิชา '+
                                    _itemsUser[index].BranchName,
                                  style: textInputStyleSub,),
                              ),
                            ],
                          ),
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

  Widget _buildContentTab1(){
    Color _color = Color(0xff556080);
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: _color);
    TextStyle textStyleSearch = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: Colors.grey[400]);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            //width: itemWidth,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
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
                      hintText: "ค้นหาชื่อผู้ใช้งาน หรือ สาขาวิชา",
                      hintStyle: textStyleSearch,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,size: 28,color: Colors.grey[400],)
                  ),
                  onChanged: onSearchTextChangedUser,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResultUser.length != 0 || controllerUser.text.isNotEmpty
                ? _buildSearchUserResults():_buildUsersList(),
          ),
        ],
      ),
        floatingActionButton: new FloatingActionButton(
            tooltip: "เพิ่มผู้ใช้งาน",
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenAddUser()),
              );
            }
        )
    );
  }

  //*****************************tab2****************************
  onSearchTextChangedBranch(String text) async {
    _searchResultBranch.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _itemsBranch.forEach((branchDetail) {
      if (branchDetail.BranchName.contains(text) ||
          branchDetail.BranchName.contains(text))
        _searchResultBranch.add(branchDetail);
    });
    setState(() {});
  }
  Widget _buildSearchKarupanResults() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black,fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: "Kanit");
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelPreview,fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      child: ListView.builder(
        itemCount: _searchResultKarupan.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child:ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScreenManageKarupan(
                          ItemKarupan: _searchResultKarupan,
                          Index: index,
                        )),
                      );
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingLabel,
                                child: Text(_searchResultKarupan[index].PName,
                                  style: textInputStyleTitle,),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(_searchResultKarupan[index].PID,
                            style: textInputStyleSub,),
                        ),
                      ],
                    ),
                    leading: Text((index+1).toString()+'.',style: textInputStyleTitle,),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildKarupanList() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black, fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

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
          _itemsKarupan = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(
                left: 4.0, right: 4.0, top: 4.0, bottom: 32.0),
            child: ListView.builder(
              itemCount: _itemsKarupan.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
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
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ScreenManageKarupan(
                                  ItemKarupan: _itemsKarupan,
                                  Index: index,
                                )),
                              );
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingLabel,
                                        child: Text(_itemsKarupan[index].PName,
                                          style: textInputStyleTitle,),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text(_itemsKarupan[index].PID,
                                    style: textInputStyleSub,),
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

  Widget _buildContentTab2(){
    Color _color = Color(0xff556080);
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: _color);
    TextStyle textStyleSearch = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: Colors.grey[400]);
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              //width: itemWidth,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: new Card(
                  elevation: 0.0,
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: new TextField(
                    style: textStyle,
                    controller: controllerKarupan,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: "ค้นหาเลขครุภัณฑ์ หรือ ชื่อครุภัณฑ์",
                        hintStyle: textStyleSearch,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,size: 28,color: Colors.grey[400],)
                    ),
                    onChanged: onSearchTextChangedBranch,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResultKarupan.length != 0 || controllerKarupan.text.isNotEmpty
                  ? _buildSearchKarupanResults():_buildKarupanList(),
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
            tooltip: "เพิ่มข้อมูลครุภัณฑ์",
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenAddKarupan()),
              );
            }
        )
    );
  }

  //*****************************tab3****************************
  onSearchTextChangedKarupan(String text) async {
    print(text);
    _searchResultKarupan.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _itemsKarupan.forEach((userDetail) {
      if (userDetail.PName.contains(text) ||
          userDetail.PID.contains(text))
        _searchResultKarupan.add(userDetail);
    });
    setState(() {});
  }
  Widget _buildSearchBranchResults() {
    Color labelColor = Colors.grey[500];
    Color labelPreview = Color(0xff556080);
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 18.0, color: Colors.black,fontFamily: "Kanit");
    TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: "Kanit");
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelPreview,fontFamily: "Kanit");
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      child: ListView.builder(
        itemCount: _searchResultBranch.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child:ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScreenManageBranch(
                          ItemBranch: _searchResultBranch,
                          Index: index,
                        )),
                      );
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingLabel,
                                child: Text(_searchResultBranch[index].BranchName,
                                  style: textInputStyleTitle,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: Text((index+1).toString()+'.',style: textInputStyleTitle,),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                ),
              ),
            ),
          );
        },
      ),
    );
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
                    //_navigateSelection(context,_searchResult[index].SectionName,_searchResult[index],_searchResult[index].ItemSuspect);
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScreenManageBranch(
                                ItemBranch: _itemsBranch,
                                Index: index,
                              )),
                            );
                          },
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
  Widget _buildContentTab3(){
    Color _color = Color(0xff556080);
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: _color);
    TextStyle textStyleSearch = TextStyle(fontFamily: "Kanit",
        fontSize: 16.0,
        color: Colors.grey[400]);
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              //width: itemWidth,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
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
                        hintText: "ค้นหาสาขาวิชา",
                        hintStyle: textStyleSearch,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,size: 28,color: Colors.grey[400],)
                    ),
                    onChanged: onSearchTextChangedBranch,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResultBranch.length != 0 || controllerBranch.text.isNotEmpty
                  ? _buildSearchBranchResults():_buildBranchList(),
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
            tooltip: "เพิ่มวิชาสาขา",
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenAddBranch()),
              );
            }
        )
    );
  }

  Future<List<_users.Users>> callDataUser() async {
    final response = await http.post(
      Server().IPAddress + "/GetUser.php",
    );
    if (response.statusCode == 200) {
      //print(response.body);
      List responseJson = json.decode(response.body);
     return responseJson.map((m) => new _users.Users.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<_karupan.Karupan>> callDataKurapan() async {
    final response = await http.post(
      Server().IPAddress + "/GetKarupan.php",
    );
    if (response.statusCode == 200) {
      //print(response.body);
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new _karupan.Karupan.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
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
