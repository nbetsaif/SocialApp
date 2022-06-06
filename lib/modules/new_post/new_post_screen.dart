import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/conditional_widget.dart';
import '../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var textController = TextEditingController();
          var userModel = SocialCubit.get(context).model;
          return ConditionalWidget(
            condition: userModel != null,
            builder: (context) => Scaffold(
              appBar: defaultAppbar(
                  context: context,
                  title: 'Create Post',
                  action: [
                    MaterialButton(
                      onPressed: () {
                        if (SocialCubit.get(context).postImage != null) {
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: DateTime.now().toIso8601String(),
                              text: textController.text);
                        } else {
                          SocialCubit.get(context).createPost(
                              dateTime: DateTime.now().toIso8601String(),
                              text: textController.text);
                        }
                      },
                      child: const Text(
                        'POST',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState ||
                        state is SocialUploadPostImageLoadingState)
                      const LinearProgressIndicator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(userModel!.image),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel.name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              'Public',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'What\'s in your mind ${userModel.name}',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 13.2),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (SocialCubit.get(context).postImage != null)
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                      image: FileImage(
                                          SocialCubit.get(context).postImage!),
                                      fit: BoxFit.cover),
                                ),
                                height: 140,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).removePostImage();
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.image,
                                color: defaultColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Photos',
                                style: TextStyle(color: defaultColor),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '# Tags',
                          style: TextStyle(color: defaultColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
