import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/chat/chat_model.dart';
import 'package:social_app/models/register/register_model.dart';
import 'package:social_app/modules/chats/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/conditional_widget.dart';

import '../../shared/styles/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalWidget(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildChatItem(context,SocialCubit.get(context).users[index],index),
                    separatorBuilder: (context, index) => Container(
                          height: 1.3,
                          color: Colors.grey[300],
                        ),
                    itemCount: SocialCubit.get(context).users.length),
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }
}

Widget buildChatItem(context, SocialUserModel model,index) => InkWell(
      onTap: () {
        navigateTo(context, ChatDetailScreen(model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(model.image),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 55,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(model.name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
