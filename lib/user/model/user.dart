class Users {
  final String UserID,AccountID,UserTypeID;
  final String UserTypeName;
  final String FirstName;
  final String LastName;
  final String TitleName;

  Users({this.UserID,this.AccountID,this.UserTypeID,this.UserTypeName,this.TitleName, this.FirstName, this.LastName,});

  factory Users.fromJson(Map<String, dynamic> json) {
    //print(json['ImageFile'].toString().substring(3,json['ImageFile'].toString().length));
    return Users(
      UserID: json['UserID'],
      AccountID: json['AccountID'],
      UserTypeID: json['UserTypeID'],
      UserTypeName: json['UserTypeName'],
      TitleName: json['TitleName'],
      FirstName: json['FirstName'],
      LastName: json['LastName'],
    );
  }
}