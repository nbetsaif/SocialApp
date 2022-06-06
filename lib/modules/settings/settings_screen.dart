import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/conditional_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return ConditionalWidget(
          condition: userModel != null,
          builder: (context) => Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
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
                                image: NetworkImage(userModel!.cover),
                                fit: BoxFit.cover),
                          ),
                          height: 140,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 59,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(userModel.image),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userModel.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  userModel.bio,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            '265',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text('Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text('Images',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            '10k',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text('Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            '68',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text('Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14))
                        ],
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: const Text('Add Photos'))),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: const Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          )),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
