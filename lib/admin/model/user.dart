class Users {
  final String UserID;
  final String Username;
  final String Password;
  final String FirstName;
  final String LastName;
  final String TitleName;
  final String UserTypeName;
  final String Position;
  final String BranchName;
  final String BranchID;

  Users({this.UserID,this.Username,this.Password,this.FirstName,this.LastName,this.TitleName, this.UserTypeName, this.Position,this.BranchName,this.BranchID});

  factory Users.fromJson(Map<String, dynamic> json) {
    //print(json['ImageFile'].toString().substring(3,json['ImageFile'].toString().length));
    return Users(
      UserID: json['UserID'],
      Username: json['Username'],
      Password: json['Password'],
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      TitleName: json['TitleName'],
      UserTypeName: json['UserTypeName'],
      Position: json['Position'],
      BranchName: json['BranchName'],
      BranchID: json['BranchID'],
    );
  }
}