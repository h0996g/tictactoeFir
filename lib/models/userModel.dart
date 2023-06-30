class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  UserModel(
      {this.id, this.name, this.email, this.password, this.phone, this.image});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }
}
