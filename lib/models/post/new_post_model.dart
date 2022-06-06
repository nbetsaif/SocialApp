class PostModel{
  late String name;
  late String uid;
  late String image;
  late String dateTime;
  late String text;
  late String? postImage;

  PostModel({
    required this.dateTime,
    required this.name,
    required this.text,
    required this.uid,
    required this.postImage,
    required this.image,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uid=json['uid'];
    postImage=json['postImage'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return
      {
        'name':name,
        'dateTime':dateTime,
        'postImage':postImage,
        'uid':uid,
        'text':text,
        'image':image,
      };
  }

}