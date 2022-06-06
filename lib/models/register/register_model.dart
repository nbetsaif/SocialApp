class SocialUserModel{
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
    required this.bio,
    required this.cover,
    required this.image,
  });

  SocialUserModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uid=json['uid'];
    isEmailVerified=json['isEmailVerified'];
    bio=json['bio'];
    cover=json['cover'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return
      {
      'name':name,
      'email':email,
      'phone':phone,
      'uid':uid,
      'isEmailVerified':isEmailVerified,
      'cover':cover,
      'image':image,
      'bio':bio,
      };
  }

}