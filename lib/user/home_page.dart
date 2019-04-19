import 'package:app_durable_articles/user/menu/fragment1.dart';
import 'package:app_durable_articles/user/menu/fragment2.dart';
import 'package:app_durable_articles/user/menu/fragmentHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_durable_articles/user/model/user.dart' as _users;

class HomePage extends StatefulWidget {
  List<_users.Users> itemsUser;
  HomePage({
    Key key,
    @required this.itemsUser,
  }) : super(key: key);
  State createState() {
    return HomePageState();
  }
}
class HomePageState extends State<HomePage> {

  final drawerItems = [
    new DrawerItem("ระบบจัดการครุภัณฑ์", AssetImage("assets/images/home.png")),
    new DrawerItem("รายการครุภัณฑ์", AssetImage("assets/images/briefcase.png")),
    new DrawerItem("ตรวจสอบครุภัณฑ์", AssetImage("assets/images/delivery.png")),
    //new DrawerItem("Fragment 3", Icons.info)
  ];
  int _selectedDrawerIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FragmentHome();
      case 1:
        return new Fragment1();
      case 2:
        return new Fragment2();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  String accountNameAvatar="";
  String accountName="";
  String accountType="";
  @override
  void initState() {
    super.initState();
    _getUserAcct();
  }
  void _getUserAcct(){
    widget.itemsUser.forEach((item){
      accountName=item.TitleName+item.FirstName+" "+item.LastName;
      accountNameAvatar=item.FirstName.substring(0,1);
      accountType=item.UserTypeName;
    });
  }

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
    TextStyle textStyleHeader = TextStyle(fontFamily: "Kanit",
        fontSize: 20.0,
        color: _color);
    TextStyle textStyleAppbar = TextStyle(fontFamily: "Kanit",
        fontSize: 20.0,
        color: _colorAppbar);
    var drawerOptions = <Widget>[];
    drawerOptions.add(
      new DrawerHeader(
          child: GestureDetector(
            onTap: (){
              _onSelectItem(0);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: _color,
                  child: Text(accountNameAvatar,style: TextStyle(fontSize: 20.0),),
                ),
                new Padding(padding: EdgeInsets.only(top:12.0),child:  Text(accountName,style: textStyleHeader,),),
                new Padding(padding: EdgeInsets.all(6.0),child:  Text('สถานะ '+accountType,style: textStyleHeader),),
              ],
            ),
          )
      ),
    );
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        new Container(
          padding: EdgeInsets.only(top:4.0,bottom: 4.0),
          //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: Container(
            decoration: i == _selectedDrawerIndex ? new BoxDecoration (
              color: _color,
            ) : null,
            alignment: Alignment.center,
            child: new ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 1),
              leading: Image(image: d.icon,
                height: 35.0,
                width: 35.0,
                fit: BoxFit.fitWidth,
                color: i == _selectedDrawerIndex ? Colors.white : _color,
              ),
              title: new Text(d.title, style: TextStyle(fontFamily: "Kanit",fontSize: 18.0,
                  color: i == _selectedDrawerIndex
                      ? Colors.white
                      : null),),
              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
            ),
          ),
        ),
      );
    }

    return  new WillPopScope(
        onWillPop: () async {
      _showDialogLogOut(context);
    },child:new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        centerTitle: true,
        title: new Text(drawerItems[_selectedDrawerIndex].title,style: textStyleAppbar,),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _showDialogLogOut(context);
            },
            icon: Icon(Icons.exit_to_app,color: _colorAppbar,),
          )
        ],
      ),
      drawer: new Drawer(
          child: new SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Column(children: drawerOptions)
                  ],
                ),
              ],
            ),
          )
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    ),
    );
  }
}
class DrawerItem {
  String title;
  AssetImage icon;
  DrawerItem(this.title, this.icon);
}