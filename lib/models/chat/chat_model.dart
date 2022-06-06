class ChatModel{

  late String name;
  late String image;
  late String phone;

  ChatModel({
    required this.name,
    required this.image,
    required this.phone,
});

  ChatModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    phone=json['phone'];
    image=json['image'];
  }
}