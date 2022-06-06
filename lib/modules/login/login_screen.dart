import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_screen_layout.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/conditional_widget.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.putData(key: 'uid', data: state.uid).then((value) {
              uid = state.uid;
              navigateWithoutComeBack(context, HomeScreen());
            });
            showToast(
                state: ToastStates.SUCCESS,
                message: 'login successfully',
                context: context);
          } else if (state is LoginErrorState) {
            showToast(
                state: ToastStates.ERROR,
                message: state.error,
                context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: Image(image: AssetImage('assets/images/logo.jpg'),width:160 ,height:160 ,fit: BoxFit.cover,)),
                        const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text('E-Mail',style: TextStyle(color: Colors.grey[800]),),
                        TextFormField(
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'address must not be empty';
                            }
                            return (null);
                          },
                          decoration:  InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            hintText: 'yourname@example.com',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Password',style: TextStyle(color: Colors.grey[800]),),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("password must not be empty");
                            }
                            return (null);
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: addressController.text,
                                  password: passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              hintText: "yourpassword",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SocialLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: SocialLoginCubit.get(context).isPassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.remove_red_eye),
                              )),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: SocialLoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalWidget(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: addressController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',

                            isUpperCase: false
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                             Text(
                              "Don't have an account yet ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 17,color: Colors.grey[800]),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
