import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  /// Rounded shape **********************************
  static var shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: kWhite,
        errorColor: kRedError,
        cardColor: kWhite,
        backgroundColor: kWhite,
        primaryColor: kUserPrimary,
        indicatorColor: kBlack,
        dividerColor: kGreyLight,
        cardTheme: CardTheme(
            elevation: 16,
            color: kWhite,
            shape: shape,
            margin: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
            color: kWhite, iconTheme: IconThemeData(color: kWhite)),
        textTheme: TextTheme(
            headline1:
                TextStyle(color: kBlack, fontSize: 16, height: 1.6, fontFamily: kAvenir),
            headline2:
                TextStyle(color: kBlack, fontSize: 16, fontFamily: kLatoBold),
            headline3: TextStyle(
                color: kBlack,
                fontSize: 14,
                fontFamily: kLatoMedium),
            bodyText1: TextStyle(
              color: kGreyDark,
              fontFamily: kLatoRegular,
              height: 1.6,
              fontSize: 14,
            ),
            button: TextStyle(
                color: kWhite, fontSize: 16, fontFamily: kLatoMedium)),
      );
}

late String kLatoBold;
late String kLatoRegular;
late String kLatoMedium;
late String kAvenir;
late String kLucidaBold;
late String kLucidaRegular;

initFonts({String? lngCode}) {
  kLatoBold = 'Lato_Bold';
  kLatoRegular =  'Lato_Regular';
  kLatoMedium =  'Lato_Medium';
  kAvenir =  'Avenir_Black';
  kLucidaBold = 'Lucida_Bold';
  kLucidaRegular =  'Lucida_Regular';
}
