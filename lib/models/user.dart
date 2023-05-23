class UserLogin {
  String? uuid;
  String? displayName;
  String? userName;
  String? password;
  String? photoURL;
  UserLogin({
    this.uuid,
    this.displayName,
    this.userName,
    this.password,
    this.photoURL
  });

  // User.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       fullName = json['fullName'],
  //       userName = json['userName'],
  //       userCode = json['userCode'],
  //       email = json['email'],
  //       sdt = json['sdt'],
  //       address = json['address'],
  //       avatar = json['avatar'],
  //       gender = json['gender'],
  //       ngaySinh = json['ngaySinh'],
  //       status = json['status'];

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'userName': userName,
        'photoURL': photoURL,
      };
}
