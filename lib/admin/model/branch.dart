class Branch {
  final String BranchID;
  final String BranchName;

  Branch({this.BranchID,this.BranchName});

  factory Branch.fromJson(Map<String, dynamic> json) {
    //print(json['ImageFile'].toString().substring(3,json['ImageFile'].toString().length));
    return Branch(
      BranchID: json['BranchID'],
      BranchName: json['BranchName'],
      //BranchName: json['BranchName'],
    );
  }
}