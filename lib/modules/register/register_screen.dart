import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_screen_layout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var addressController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return (null);
                      },
                      decoration: InputDecoration(
                          label: const Text('Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'address must not be empty';
                        }
                        return (null);
                      },
                      decoration: InputDecoration(
                          label: const Text('Email Address'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: const Icon(Icons.email)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone number must not be empty';
                        }
                        return (null);
                      },
                      decoration: InputDecoration(
                          label: const Text('Phone'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          prefixIcon: const Icon(Icons.phone)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("password must not be empty");
                        }
                        return (null);
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            RegisterCubit.get(context).changeVisibility();
                          },
                          icon: RegisterCubit.get(context).isPassword
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                      obscureText: RegisterCubit.get(context).isPassword,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        function: () {
                          RegisterCubit.get(context).register(
                              email: addressController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              password: passwordController.text);
                        },
                        text: 'Register'),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is RegisterLoadingState)
                      const LinearProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
        );
      },
          listener: (context, state) {
        if (state is RegisterCreateUserSuccessState) {
          CacheHelper.putData(key: 'uid', data: state.uid);
          uid=state.uid;
          navigateWithoutComeBack(context, const HomeScreen());
        }
      }),
    );
  }
}
