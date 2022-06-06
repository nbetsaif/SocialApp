import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.model;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: 'Edit Profile', action: [
            MaterialButton(
              onPressed: () {
                if (cubit.profileImage != null && cubit.coverImage != null) {
                  print('here 1');
                  cubit.uploadProfileImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                  cubit.uploadCoverImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                } else if (cubit.profileImage != null) {
                  print('here 2');
                  cubit.uploadProfileImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                } else if (cubit.coverImage != null) {
                  print('here 3 ');
                  cubit.uploadCoverImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                } else {
                  print('here 4');
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                }
              },
              child: const Text(
                'UPDATE',
                style: TextStyle(color: defaultColor),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
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
                                        image: cubit.coverImage == null
                                            ? NetworkImage(userModel.cover)
                                            : FileImage(cubit.coverImage!)
                                                as ImageProvider,
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
                                      cubit.getCoverImage();
                                    },
                                    icon: const Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 59,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: cubit.profileImage == null
                                      ? NetworkImage(userModel.image)
                                      : FileImage(cubit.profileImage!)
                                          as ImageProvider,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                    icon: const Icon(Icons.camera_alt_outlined),
                                    iconSize: 20,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val == null) {
                          return 'name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                          label: Text('Name'),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val == null) {
                          return 'bio must not be empty';
                        } else {
                          return null;
                        }
                      },
                      controller: bioController,
                      decoration: const InputDecoration(
                          label: Text('Bio'),
                          prefixIcon: Icon(Icons.info_outline),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val == null) {
                          return 'phone must not be empty';
                        } else {
                          return null;
                        }
                      },
                      controller: phoneController,
                      decoration: const InputDecoration(
                          label: Text('Phone'),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
