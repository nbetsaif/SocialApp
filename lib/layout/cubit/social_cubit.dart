import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/chat/chat_model.dart';
import 'package:social_app/models/chat/message_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../models/post/new_post_model.dart';
import '../../models/register/register_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'NewPost', 'Users', 'Settings'];

  void changeBotIndex(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      if (index == 1) {
        getAllUsers();
      }
      currentIndex = index;
      emit(SocialChangeBotNavBarState());
    }
  }

  File? profileImage;

  Future getProfileImage() async {
    ImagePicker picker = ImagePicker();
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      profileImage = File(pikedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    ImagePicker picker = ImagePicker();
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      coverImage = File(pikedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String? profileImageUrl;

  void uploadProfileImage({required name, required phone, required bio}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio);
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;

  void uploadCoverImage({required name, required phone, required bio}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio);
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({required name, required phone, required bio}) {
    SocialUserModel usermodel = SocialUserModel(
      email: model!.email,
      name: name,
      phone: phone,
      uid: model!.uid,
      isEmailVerified: false,
      image: profileImageUrl == null ? model!.image : profileImageUrl!,
      bio: bio,
      cover: coverImageUrl == null ? model!.cover : coverImageUrl!,
    );
    emit(SocialUpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState(error));
    });
  }

  File? postImage;

  Future getPostImage() async {
    ImagePicker picker = ImagePicker();
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      postImage = File(pikedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  String? postImageUrl;

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;
        createPost(dateTime: dateTime, text: text);
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel? postModel = PostModel(
        dateTime: dateTime,
        name: model!.name,
        text: text,
        uid: model!.uid,
        postImage: postImageUrl,
        image: model!.image);

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      removePostImage();
      postImageUrl = null;
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> postLikesNumber = [];
  List<int> postCommentsNumber = [];
  List<List<String>> allComments = [];
  List<SocialUserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.id != model!.uid)
            users.add(SocialUserModel.fromJson(element.data()));
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.collection('likes').get().then((value) async {
          postLikesNumber.add(value.docs.length);
          allComments.add([]);
          await element.reference
              .collection('comments')
              .get()
              .then((value) async {
            int comments = 0;
            for (var element in value.docs) {
              await element.reference.get().then((value) {
                comments += value.data()!['comments'].length as int;
                allComments[allComments.length - 1] =
                    List.from(value.data()!['comments']);
              }).catchError((error) {
                print(error.toString());
              });
            }
            postCommentsNumber.add(comments);
            comments = 0;
            posts.add(PostModel.fromJson(element.data()));
            postId.add(element.id);
            emit(SocialGetPostsSuccessState());
          }).catchError((error) {});
        }).catchError((error) {});
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void commentPosts(String postId, String comment, int index) {
    allComments[index].insert(allComments[index].length, comment);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uid)
        .set({'comments': allComments[index]}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void sendMessage(
      {required String receiverId,
      required String dateTime,
      required String text}) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      text: text,
      recieverId: receiverId,
      senderId: model!.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialPostMessSuccessState());
    }).catchError((error) {
      emit(SocialPostMessErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialPostMessSuccessState());
    }).catchError((error) {
      emit(SocialPostMessErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessSuccessState());
    });
  }
}
