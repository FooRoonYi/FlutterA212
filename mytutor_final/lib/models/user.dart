class User {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? password;
  String? address;
  String? credit;
  String? otp;
  String? datereg;
  String? cart;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNo,
      this.password,
      this.address,
      this.credit,
      this.otp,
      this.datereg,
      this.cart});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    password = json['password'];
    address = json['address'];
    credit = json['credit'];
    otp = json['otp'];
    datereg = json['datereg'];
    cart = json['cart'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['password'] = password;
    data['address'] = address;
    data['credit'] = credit;
    data['otp'] = otp;
    data['datereg'] = datereg;
    data['cart'] = cart.toString();
    return data;
  }
}
