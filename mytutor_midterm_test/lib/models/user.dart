class User {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? password;
  String? address;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNo,
      this.password,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    password = json['password'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['password'] = password;
    data['address'] = address;
    return data;
  }
}
