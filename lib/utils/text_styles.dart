import 'package:flutter/material.dart';


///Custom TextStyles
class CustomTextStyles{

  static final mainTextStyle = TextStyle(color: Colors.white);

  static final headingTextStyle = mainTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold);

  static final subHeadingTextStyle = mainTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold);

  static final titleTextStyle = TextStyle(fontSize: 12, color: Colors.black);

  static final subTitleTextStyle = TextStyle(fontSize: 10, color: Colors.black);
}