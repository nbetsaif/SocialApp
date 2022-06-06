import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post/new_post_model.dart';
import 'package:social_app/shared/components/conditional_widget.dart';
import 'package:social_app/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  var textcont = TextEditingController();
  var commentcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalWidget(
          condition: cubit.posts.isNotEmpty && cubit.model != null,
          builder: (context) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    Card(
                      margin: EdgeInsets.all(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Image(
                        width: double.infinity,
                        height: 220,
                        image: NetworkImage(
                            'https://img.freepik.com/photos-gratuite/portrait-homme-seduisant-heureux-satisfait-satisfait-chemise-mode-denim-montrant-son-index-coin-superieur-droit_295783-1217.jpg?w=740'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 100,
                        right: 15,
                      ),
                      child: Text(
                        'communicate with friends',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return index.isEven
                    ? buildPostItem(cubit.posts[index ~/ 2], context, index ~/ 2)
                    : const SizedBox(
                        height: 13,
                      );
              }, childCount: cubit.posts.length * 2 - 1))
            ],
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel postModel, context, index) {
  var commentcont = TextEditingController();
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(postModel.image),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(postModel.name,
                          style: Theme.of(context).textTheme.subtitle2),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.check_circle, color: defaultColor)
                    ],
                  ),
                  Text(postModel.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.7, fontSize: 13)),
                ],
              )),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 1.2,
              color: Colors.grey[400],
            ),
          ),
          Text(
            postModel.text,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.2),
          ),
          // Wrap(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 4),
          //       child: SizedBox(
          //         height: 25,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           height: 20,
          //           padding: EdgeInsets.zero,
          //           onPressed: (){},
          //           child: const Text('#Software',
          //             style: TextStyle(fontSize: 18,color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 4),
          //       child: SizedBox(
          //         height: 25,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           height: 20,
          //           padding: EdgeInsets.zero,
          //           onPressed: (){},
          //           child: const Text('#flutter',
          //             style: TextStyle(fontSize: 18,color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 4),
          //       child: SizedBox(
          //         height: 25,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           height: 20,
          //           padding: EdgeInsets.zero,
          //           onPressed: (){},
          //           child: const Text('#Mobile',
          //             style: TextStyle(fontSize: 18,color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 4),
          //       child: SizedBox(
          //         height: 25,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           height: 20,
          //           padding: EdgeInsets.zero,
          //           onPressed: (){},
          //           child: const Text('#Developement',
          //             style: TextStyle(fontSize: 18,color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 4),
          //       child: SizedBox(
          //         height: 27,
          //         child: MaterialButton(
          //           minWidth: 1,
          //           height: 20,
          //           padding: EdgeInsets.zero,
          //           onPressed: (){},
          //           child: const Text('#Coding',
          //             style: TextStyle(fontSize: 18,color: defaultColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 8,
          ),
          // const SizedBox(height: 8,),
          if (postModel.postImage != null)
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(postModel.postImage!),
                      fit: BoxFit.cover)),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.pink,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${SocialCubit.get(context).postLikesNumber[index]}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 12.7),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${SocialCubit.get(context).postCommentsNumber[index]} comments',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 13),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              height: 1.2,
              color: Colors.grey[400],
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage(SocialCubit.get(context).model!.image),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextFormField(
                onFieldSubmitted: (value) {
                  SocialCubit.get(context).commentPosts(
                      SocialCubit.get(context).postId[index], commentcont.text,index);
                },
                controller: commentcont,
                decoration: InputDecoration(
                  hintText: 'Write a comment ...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 13.2),
                  border: InputBorder.none,
                ),
              )),
              InkWell(
                onTap: () {
                  SocialCubit.get(context)
                      .likePosts(SocialCubit.get(context).postId[index]);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.pink,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16.5),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.screen_share_outlined,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Share',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 17),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          )
        ],
      ),
    ),
  );
}
