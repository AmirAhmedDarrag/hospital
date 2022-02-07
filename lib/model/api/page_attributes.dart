import 'package:flutter/material.dart';


class PageAttributes {
  //Data
  final bool showAppBar, isHome, resizeToAvoidBottomInset, transparentAppBar;
  final double appBarElevation;
  final String? title;
  final Color appBarColor, foregroundColor;
  final bool extendBody;
  final bool showLogo;
  final bool showTitle;

  PageAttributes(
      {this.showAppBar = true,
      this.isHome = false,
      this.title,
      this.appBarElevation = 6,
      this.foregroundColor = Colors.green,
      this.extendBody = false,
      this.appBarColor = Colors.white,
      this.showLogo = true,
      this.showTitle = true,
      this.transparentAppBar = false,
      this.resizeToAvoidBottomInset = false});
}
