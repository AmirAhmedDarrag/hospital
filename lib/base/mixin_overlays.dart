

import 'package:get/get.dart';
import 'package:hospital/base/dialogs/confirmation_dialog.dart';


mixin Overlays {
  showConfirmationDialog(
      {required String body, required Function okCallback}) {
     Get.dialog(ConfirmationDialog(
         text: body,
         onOkClick: () {
           Get.back();
           okCallback.call();
         }),barrierDismissible: false,);
  }

}
