class UserModel {

  String? id;
  String? name;

  UserModel({this.id, this.name});

}

class ScannedUser {

  UserModel? userModel;
  DateTime? date;

  ScannedUser({this.date, this.userModel});

}