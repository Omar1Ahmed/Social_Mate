import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {
  static const inter18Bold = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter');

  static const inter14RegularBlue = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Inter', color: ColorsManager.primaryColor);
  static const inter18Regular = TextStyle(fontSize: 18, fontWeight: FontWeight.normal, fontFamily: 'Inter', color: Colors.black);
  static const inter18BoldBlack = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: Colors.black);
}

class TextFieldStyles {
  static final inputDecorationTitleFiled = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorsManager.primaryColor.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(100),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(100),
    ),
  );
  static final inputDecorationContentFiled = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(100),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(100),
    ),
  );
}
