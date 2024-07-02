import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;

  }

  static get widthSize{
    return screenWidth;
  }

  static get heightSize{
    return screenHeight;
  }

  //spacing
  static const spacesmall = SizedBox(height: 25,);
  static final spacesMedium = SizedBox(height: screenHeight! * 0.05,);
  static final spacesBig = SizedBox(height: screenHeight! * 0.08,);


  //textform field border
  static const OutlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8))
  );

    static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.greenAccent,
    )
  );

      static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Color.fromARGB(255, 190, 6, 6),
    )
  );
  static const primsryColor = Colors.greenAccent;
} 