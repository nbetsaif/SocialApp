import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/social_screen_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  late Widget widget;
  uid=CacheHelper.getData(key: 'uid');
  var token= await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  if(uid!=null)
    {
      widget =HomeScreen();
    }
  else
  {
    widget= LoginScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()..getAllUsers(),
    child: BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return MaterialApp(
          darkTheme: darkTheme,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        );
      },
    ),
    );
  }
}
