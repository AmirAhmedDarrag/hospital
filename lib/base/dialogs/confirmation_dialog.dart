import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/theme/app_colors.dart';
import 'package:hospital/theme/app_themes.dart';
import 'package:hospital/widgets/buttons/base_text_button.dart';



class ConfirmationDialog extends StatefulWidget {
  final String? text;
  final Widget? bodyWidget;
  final String? okText;
  final String? cancelTxt;
  final bool hideCancel;
  final GestureTapCallback onOkClick;

  const ConfirmationDialog(
      {Key? key,
       this.text,
        this.bodyWidget,
      required this.onOkClick,
      this.cancelTxt,
      this.hideCancel = false,
      this.okText})
      : super(key: key);

  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();
}

class ConfirmationDialogState extends State<ConfirmationDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!Platform.isIOS) controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(children: [
      Material(
        color: Colors.transparent,
        child: Platform.isAndroid
            ? ScaleTransition(
                scale: scaleAnimation!,
                child: buildBody(),
              )
            : buildBody(),
      )
    ]));
  }

  Widget buildBody() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGreyDark.withOpacity(0.1), width: 1)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                widget.text == null? widget.bodyWidget! : Text(
                    widget.text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kUserPrimary,
                        height: 1.6,
                        fontFamily: kLatoBold,
                        fontSize: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Visibility(
                      visible: !widget.hideCancel,
                      child: BaseTextButton(
                        title: widget.cancelTxt ?? 'cancel'.tr,
                        primary: kWhite,
                        borderColor: kUserPrimary,
                        width: 85,
                        height: 35,
                        fontSize: 13,
                        txtColor: kUserPrimary,
                        onPress: () => Get.back(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                    ),
                    BaseTextButton(
                      title: widget.cancelTxt ?? 'ok'.tr,
                      width: 85,
                      height: 35,
                      fontSize: 13,
                      onPress: () => widget.onOkClick.call(),
                    )
                  ])
                ])));
  }
}
