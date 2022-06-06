import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(
    {
      double width=double.infinity,
      Color backgroundColor=Colors.blueAccent,
      bool isUpperCase=true,
      double radius=3,
      required void Function() function,
      required String text
    }
    ){
  return Container(
    width: width,
    height: 50,
    child: MaterialButton(
      child: Text(isUpperCase? text.toUpperCase():text ,
        style: const TextStyle(color: Colors.white,fontSize: 20),),
      onPressed: function,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor
    ),
  );
}

void navigateTo(context,Widget screen)
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}

void navigateWithoutComeBack(context , Widget screen)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>screen), (route) => false);
}

void showToast({
  required ToastStates state,
  required message,
  required context
})
{
  Fluttertoast.showToast(
      msg: message,
    backgroundColor: chooseToastColor(state),
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    fontSize: 18,
    textColor: Colors.white
  );
}

enum ToastStates{ERROR,SUCCESS,WARNING}
Color chooseToastColor(ToastStates state){
  switch(state)
  {
    case ToastStates.SUCCESS :
      return Colors.green;
    case ToastStates.ERROR :
      return Colors.red;
    case ToastStates.WARNING :
      return Colors.amber;
  }
}

PreferredSizeWidget defaultAppbar({
  required context,
  String title='',
  List<Widget>? action,
})=>AppBar(
  titleSpacing: 5,
  title: Text(title),
  actions: action,
);