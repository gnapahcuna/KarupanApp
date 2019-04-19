import 'dart:convert';
import 'dart:io';
import 'package:app_durable_articles/admin/screen_user_select_branch.dart';
import 'package:app_durable_articles/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'model/karupan.dart' as _karupan;

class ScreenEditKarupan extends StatefulWidget {
  List<_karupan.Karupan> ItemKarupan;
  int Index;
  ScreenEditKarupan({
    Key key,
    @required this.ItemKarupan,
    @required this.Index,
  }) : super(key: key);
  State createState() {
    return Fragment1State();
  }
}
class Fragment1State extends State<ScreenEditKarupan> {

  final FocusNode myFocusNodeYear = FocusNode();
  final FocusNode myFocusNodeDepartment = FocusNode();
  final FocusNode myFocusNodePID = FocusNode();
  final FocusNode myFocusNodePName = FocusNode();
  final FocusNode myFocusNodeExpired = FocusNode();
  final FocusNode myFocusNodeBulid= FocusNode();
  final FocusNode myFocusNodeFloorNum = FocusNode();
  final FocusNode myFocusNodeRoom= FocusNode();
  final FocusNode myFocusNodeDetail= FocusNode();
  final FocusNode myFocusNodeCheckStatus = FocusNode();
  final FocusNode myFocusNodeLocal = FocusNode();


  TextEditingController YearController = new TextEditingController();
  TextEditingController DepartmentController = new TextEditingController();
  TextEditingController PIDController = new TextEditingController();
  TextEditingController PNameController = new TextEditingController();
  TextEditingController ExpiredController = new TextEditingController();
  TextEditingController BulidController = new TextEditingController();
  TextEditingController FloorNumController = new TextEditingController();
  TextEditingController RoomController = new TextEditingController();
  TextEditingController DetailController = new TextEditingController();
  TextEditingController CheckStatusController = new TextEditingController();
  TextEditingController LocalController = new TextEditingController();

  String _dropdownUserCheckStatus="ปกติ";
  List<String> itemsCheckStatus=['ปกติ','ชำรุด','จำหน่าย','บริจาค'];

  String branchID,branchName;

  Future<File> _imageFile;
  String _base64;
  List<String> years = <String>[];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    YearController.text=widget.ItemKarupan[widget.Index].Year;
    DepartmentController.text=widget.ItemKarupan[widget.Index].Department;
    PIDController.text=widget.ItemKarupan[widget.Index].PID;
    PNameController.text=widget.ItemKarupan[widget.Index].PName;
    ExpiredController.text=widget.ItemKarupan[widget.Index].Expired;
    BulidController.text=widget.ItemKarupan[widget.Index].Build;
    FloorNumController.text=widget.ItemKarupan[widget.Index].FloorNum;
    RoomController.text=widget.ItemKarupan[widget.Index].Room;
    DetailController.text=widget.ItemKarupan[widget.Index].Detail;
    CheckStatusController.text=widget.ItemKarupan[widget.Index].CheckStatusName;
    LocalController.text=widget.ItemKarupan[widget.Index].Local;
    branchID=widget.ItemKarupan[widget.Index].BranchID;
    branchName=widget.ItemKarupan[widget.Index].BranchName;

    var formatter = new DateFormat('yyyy');
    String year = formatter.format(DateTime.now());
    for(int i=int.parse(year);i<int.parse(year)+10;i++){
      years.add((i+543).toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    YearController.dispose();
    DepartmentController.dispose();
    PIDController.dispose();
    PNameController.dispose();
    ExpiredController.dispose();
    BulidController.dispose();
    FloorNumController.dispose();
    RoomController.dispose();
    DetailController.dispose();
    CheckStatusController.dispose();
    LocalController.dispose();
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

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
      print(_imageFile.toString());
      _imageFile.then((f){
        List splits = f.path.split("/");
        print(splits[splits.length-1]);

      });
    });
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            List<int> imageBytes = snapshot.data.readAsBytesSync();
            String base64Image = base64Encode(imageBytes);
            _base64=base64Image;

            return Container(
              padding: EdgeInsets.all(12.0),
              /*width: (MediaQuery
                  .of(context)
                  .size
                  .width*80)/100,
              height:  MediaQuery
                  .of(context)
                  .size
                  .height/2.5,*/
              child: Image.file(snapshot.data,fit: BoxFit.contain,),
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return Center(
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
            );
          }
        });
  }

  void _showDialogImage(){
    showDialog(context: context,builder: (context) => _onTapImage(context)); // Call the Dialog.
  }
  _onTapImage(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff556080),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.camera_alt, color: Colors.white, size: 38.0,),
                ),
                onTap: (){
                  _onImageButtonPressed(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff556080),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.image, color: Colors.white, size: 38.0,),
                ),
                  onTap: (){
                    _onImageButtonPressed(ImageSource.gallery);
                    Navigator.pop(context);
                  },
              ),
            ],
          )
        ],
      ),
    );
  }
  _navigateSelectBrnach(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenUserSelectBranch(
      )),
    );
    if(result.toString()!="back") {
      setState(() {
        List splits = result.toString().split(",");
        branchID = splits[0];
        branchName = splits[1];
      });
    }else{
      setState(() {
        branchName=widget.ItemKarupan[widget.Index].BranchName;
        branchID=widget.ItemKarupan[widget.Index].BranchID;
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    Color _color = Color(0xff556080);
    Color _colorAppbar = Colors.white;
    Color _color1 = Colors.grey[500];
    TextStyle textStyle = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: _color);
    TextStyle textStyleSelect = TextStyle(fontFamily: "Kanit",
        fontSize: 18.0,
        color: Colors.blue);
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
    final makeBottom = new Container(
      //margin: EdgeInsets.only(bottom: 18.0),
      height: 55.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0)
          )
      ),
      child:RaisedButton(
        color: Colors.grey[500],
        onPressed: () {
          _navigateSelectBrnach(context);
        },
        child: Center(
          child: Text(
              'เลือกสาขาวิชา',
              style: textStyleTabbar
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text('บันทึก', style: textStyleAppbar,),
            onPressed: () {
              String year = years[_selectedIndex];
              String department = DepartmentController.text;
              String pid = PIDController.text;
              String panme = PNameController.text;
              String expire = ExpiredController.text;
              String build = BulidController.text;
              String floor_num = FloorNumController.text;
              String room = RoomController.text;
              String detail = DetailController.text;
              int checkstatus;
              String local = LocalController.text;

              if(_dropdownUserCheckStatus.endsWith("ปกติ")){
                checkstatus=1;
              }else if(_dropdownUserCheckStatus.endsWith("ชำรุด")){
                checkstatus=2;
              }else if(_dropdownUserCheckStatus.endsWith("จำหน่าย")){
                checkstatus=3;
              }else{
                checkstatus=4;
              }

              if (year.isEmpty||
                  department.isEmpty||
                  pid.isEmpty||
                  panme.isEmpty||
                  expire.isEmpty||
                  build.isEmpty||
                  floor_num.isEmpty||
                  room.isEmpty||
                  detail.isEmpty||
                  local.isEmpty
              ) {
                _showAlertDialog('กรุณากรอกข้อมูลครบทุกช่อง!');
              } else {
                sendData(
                    year,
                    department,
                    pid,
                    panme,
                    expire,
                    build,
                    floor_num,
                    room,
                    detail,
                    checkstatus,
                    local,
                    context
                );


              }
            },
          )
        ],
        title: Text('แก้ไขครุภัณฑ์', style: textStyleAppbar),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _previewImage(),
                Padding(
                  padding: EdgeInsets.only(top: (size.height * 2) / 100,),
                  child: Card(
                      color: _color,
                      shape: new RoundedRectangleBorder(
                          side: new BorderSide(
                              color: _color, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      elevation: 0.0,
                      child: Container(
                        width: size.width/2,
                        child: MaterialButton(
                          onPressed: () {
                            _showDialogImage();
                          },
                          splashColor: Colors.grey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("อัพโหลดรูปภาพ", style: textStyleAppbar,),
                              Icon(Icons.file_upload,color: _colorAppbar,)
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12.0),
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: /*TextField(
                    focusNode: myFocusNodeYear,
                    controller: YearController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ปีงบประมาณ",
                      labelStyle: textStyleHint,
                    ),
                  ),*/
                  Row(
                    children: <Widget>[
                      CupertinoButton(
                          child: Text("เลือกปีงบประมาณ : ",style: textStyleSelect,),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200.0,
                                    child: CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                        children: new List<Widget>.generate(
                                            years.length, (int index) {
                                          return new Center(
                                            child: new Text(years[index],style: textStyle,),
                                          );
                                        })),
                                  );
                                });
                          }),
                      Text(
                        years[_selectedIndex],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeDepartment,
                    controller: DepartmentController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ชื่อหน่วยงาน",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodePID,
                    controller: PIDController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "หมายเลขครุภัณฑ์ ",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodePName,
                    controller: PNameController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ชื่อครุภัณฑ์",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeExpired,
                    controller: ExpiredController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "จำนวน",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeBulid,
                    controller: BulidController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "อาคาร",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeFloorNum,
                    controller: FloorNumController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ชั้น",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeRoom,
                    controller: RoomController,
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "ห้อง",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    maxLines: 3,
                    focusNode: myFocusNodeDetail,
                    controller: DetailController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "รายละเอียดครุภัณฑ์",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                  width: (size.width*80)/100,
                  //padding: paddingInputBox,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _dropdownUserCheckStatus,
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownUserCheckStatus = newValue;
                        });
                      },
                      items: itemsCheckStatus
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                /*Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeCheckStatus,
                    controller: CheckStatusController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "สถานะ",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
               */
                Container(
                  width: (size.width * 80) / 100,
                  //top: (size.height*5)/100, bottom: (size.height*5)/100, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodeLocal,
                    controller: LocalController,
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "สถานที่เก็บ",
                      labelStyle: textStyleHint,
                    ),
                  ),
                ),
                Container(
                  width: (size.width * 80) / 100,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Container(
                    width: (size.width*80)/100,
                    padding: EdgeInsets.only(top: 22.0,bottom: 12.0),
                    child: Center(
                      child: Text('สาขาวิชา : ' + branchName,style: textStyle,),
                    )
                ),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: makeBottom,
    );
  }

  Future<http.Response> callAddKarupan(department,
      pid,
      panme,
      expire,
      build,
      floor_num,
      room,
      detail,
      checkstatus,
      local) async {
    final paramDic = {
      "KarupanID":widget.ItemKarupan[widget.Index].KarupanID,
      "ImageFile":_base64,
      "Year":years[_selectedIndex],
      "Department": department,
      "PID":pid,
      "PName": panme,
      "Expired":expire,
      "Build": build,
      "FloorNum":floor_num,
      "Room": room,
      "Detail":detail,
      "CheckStatus": checkstatus.toString(),
      "Local":local,
      "BranchID":branchID,
    };
    final addUser = await http.post(
      Server().IPAddress + "/EditKarupan.php", // change with your API
      body: paramDic,

    );
    print("res :"+addUser.statusCode.toString());
    return addUser;
  }

  void sendData( year,
      department,
      pid,
      panme,
      expire,
      build,
      floor_num,
      room,
      detail,
      checkstatus,
      local,
      mContext)async{

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color(0xff556080)),),);
        });
    await onLoadAction(
        year,
        department,
        pid,
        panme,
        expire,
        build,
        floor_num,
        room,
        detail,
        checkstatus,
        local,
        mContext
    );
    Navigator.pop(context);
    Navigator.pop(context);

  }
  Future<bool> onLoadAction(
      year,
      department,
      pid,
      panme,
      expire,
      build,
      floor_num,
      room,
      detail,
      checkstatus,
      local,
      mContext
      ) async {
    await callAddKarupan(department,
        pid,
        panme,
        expire,
        build,
        floor_num,
        room,
        detail,
        checkstatus,
        local);
    return true;
  }
}