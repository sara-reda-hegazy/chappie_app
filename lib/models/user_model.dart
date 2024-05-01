
class UserModel{
  String ? name;
  int ? phone;
  String ? address;
  String ? email;
  String ? imageUrl;

  UserModel({this.name,this.phone,this.email,this.address,this.imageUrl});

  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
    email: json['email'],
    imageUrl: json['imageUl']
  );

  Map<String,dynamic>toJson()=>{
    'name':name,
    'phone':phone,
    'address':address,
    'email':email,
    'imageUrl':imageUrl,

  };

}