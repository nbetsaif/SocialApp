import '../../models/post/new_post_model.dart';

abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBotNavBarState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates
{
  String error;
  SocialUpdateUserErrorState(this.error);
}

//post

class   SocialCreatePostLoadingState extends SocialStates{}

class   SocialCreatePostSuccessState extends SocialStates{}

class   SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageSuccessState extends SocialStates{}

class SocialUploadPostImageLoadingState extends SocialStates{}

class SocialUploadPostImageSuccessState extends SocialStates{}

class SocialUploadPostImageErrorState extends SocialStates{}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  String error;
  SocialGetPostsErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates
{
  String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates
{
  String error;
  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates
{
  String error;
  SocialCommentPostErrorState(this.error);
}

class SocialGetMessSuccessState extends SocialStates{}

class SocialGetMessErrorState extends SocialStates
{
  String error;
  SocialGetMessErrorState(this.error);
}

class SocialPostMessSuccessState extends SocialStates{}

class SocialPostMessErrorState extends SocialStates
{
  String error;
  SocialPostMessErrorState(this.error);
}