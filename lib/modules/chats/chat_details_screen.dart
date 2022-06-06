import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/chat/message_model.dart';
import 'package:social_app/models/register/register_model.dart';
import 'package:social_app/shared/components/conditional_widget.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../models/chat/chat_model.dart';

// ignore: must_be_immutable
class ChatDetailScreen extends StatelessWidget {
  SocialUserModel model;

  ChatDetailScreen(this.model, {Key? key}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(model.uid);
      return BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                    titleSpacing: 0,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(model.image),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(model.name,
                                  maxLines: 1,
                                  style:
                                  Theme.of(context).textTheme.subtitle1),
                            ),
                          ),
                        ),
                      ],
                    )),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ConditionalWidget(
                        condition: cubit.messages.isNotEmpty,
                        builder: (context)=>Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (model.uid ==
                                    cubit.messages[index].senderId) {
                                  return buildReceiveItem(
                                      cubit.messages[index]);
                                }
                                return buildSendItem(cubit.messages[index]);
                              },
                              separatorBuilder: (context, index) => const SizedBox(),
                              itemCount: cubit.messages.length),
                        ),
                        fallback: (context)=>const Expanded(child: SizedBox( height:50,width:50,child: Center(child: CircularProgressIndicator()))),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tap Your Message Here ...'),
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              margin: EdgeInsets.zero,
                              color: defaultColor,
                              child: MaterialButton(
                                  minWidth: 1,
                                  padding: const EdgeInsets.all(13.5),
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: model.uid,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  },
                                  child: const Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
          listener: (context, state) {});
    });
  }
}

Widget buildReceiveItem(MessageModel model) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0),
  child:   Align(

        alignment: AlignmentDirectional.centerStart,

        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

          decoration: BoxDecoration(

            color: Colors.grey[300],

            borderRadius: const BorderRadiusDirectional.only(

              topStart: Radius.circular(12),

              topEnd: Radius.circular(12),

              bottomEnd: Radius.circular(12),

            ),

          ),

          child: Text(model.text),

        ),

      ),
);

Widget buildSendItem(MessageModel model) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0),
  child:   Align(

        alignment: AlignmentDirectional.centerEnd,

        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

          decoration: BoxDecoration(

            color: defaultColor.withOpacity(0.2),

            borderRadius: const BorderRadiusDirectional.only(

              topStart: Radius.circular(12),

              topEnd: Radius.circular(12),

              bottomStart: Radius.circular(12),

            ),

          ),

          child: Text(model.text),

        ),

      ),
);
