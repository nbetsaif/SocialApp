import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){
          if (state is SocialNewPostState)
            {
              navigateTo(context, NewPostScreen());
            }
        },
        builder: (context,state){
         var cubit= SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed:(){}, icon: const Icon(Icons.notifications_none)),
                IconButton(onPressed:(){}, icon: const Icon(Icons.search))
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              title:  Text(cubit.titles[cubit.currentIndex],style: const TextStyle(color: Colors.black,fontSize: 25)),
            ),

            body: Column(
              children: [
                // if(FirebaseAuth.instance.currentUser!.emailVerified)
                // Container(
                //   color: Colors.amber.withOpacity(0.6),
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       const Icon(Icons.info_outline),
                //       const SizedBox(width: 10,),
                //       const Expanded(child: Text('please verify your email')),
                //       TextButton(
                //           onPressed: ()
                //           {
                //             FirebaseAuth.instance.currentUser!.sendEmailVerification().
                //             then((value)
                //                 {
                //                   showToast(
                //                       state: ToastStates.SUCCESS,
                //                       message: 'Check Your Email',
                //                       context: context);
                //                 }
                //             ).catchError(
                //                     (error)
                //
                //                 {
                //
                //                 });
                //           },
                //           child: Text('Send'.toUpperCase(),))
                //     ],
                //   ),
                // ),
                Expanded(
                    child:  cubit.screens[cubit.currentIndex])
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              onTap: (int index){
                cubit.changeBotIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Chat"),
                BottomNavigationBarItem(icon: Icon(Icons.cloud_upload_outlined),label: "Post"),
                BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined),label: "Users"),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
              ],
              currentIndex: cubit.currentIndex,
            ),
          );
        },

    );
  }
}
