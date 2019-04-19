class Karupan {
  final String KarupanID;
  final String Year;
  final String Department;
  final String PID;
  final String PName;
  final String Expired;
  final String Build;
  final String FloorNum;
  final String Room;
  final String Detail;
  final String CheckStatusCode;
  final String CheckStatusName;
  final String Local;
  final String BranchName;
  final String BranchID;
  final String ImageFile;

  Karupan({this.KarupanID,this.Year,this.Department,this.PID,this.PName,this.Expired,this.Build,this.FloorNum,this.Room,this.Detail,this.CheckStatusCode,this.CheckStatusName,this.Local,this.BranchName,this.BranchID,this.ImageFile});

  factory Karupan.fromJson(Map<String, dynamic> json) {
    return Karupan(
      KarupanID: json['KarupanID'],
      Year: json['Year'],
      Department: json['Department'],
      PID: json['PID'],
      PName: json['PName'],
      Expired: json['Expired'],
      Build: json['Build'],
      FloorNum: json['FloorNum'],
      Room: json['Room'],
      Detail: json['Detail'],
      CheckStatusCode: json['CheckStatusCode'],
      CheckStatusName: json['CheckStatus'],
      Local: json['Local'],
      BranchName: json['BranchName'],
      BranchID: json['BranchID'],
      ImageFile: json['ImageFile'],
    );
  }
}