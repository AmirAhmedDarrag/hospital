import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/theme/app_colors.dart';
import 'package:hospital/theme/app_themes.dart';


class BaseTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final Color primary;
  final double height;
  final double? width;
  final double radius;
  final String? fontFamily;
  final double fontSize;
  final Color? borderColor;
  final Color? txtColor;

  const BaseTextButton(
      {Key? key,
      required this.title,
      this.width,
      this.txtColor,
      this.onPress,
      this.primary = kUserPrimary,
      this.radius = 25,
      this.height = 45,
      this.fontFamily,
      this.borderColor,
      this.fontSize = 16})
      : super(key: key);

  const BaseTextButton.agent(
      {Key? key,
        required this.title,
        this.width,
        this.txtColor,
        this.onPress,
        this.primary = kAgentPrimary,
        this.radius = 25,
        this.height = 45,
        this.fontFamily,
        this.borderColor,
        this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        child: Text(title,
            style: Get.textTheme.headline2?.copyWith(
                fontFamily: fontFamily ?? kAvenir,
                fontSize: fontSize,
                color: txtColor ?? kWhite)),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                side: BorderSide(color: borderColor ?? primary, width: 1)),
            minimumSize: Size(width ?? double.infinity, height),
            padding: const EdgeInsets.all(6),
            primary: primary,
            onPrimary: Colors.white.withOpacity(0.4)));
  }
}
