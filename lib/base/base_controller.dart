import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/base/base_repository.dart';
import 'package:hospital/base/mixin_overlays.dart';
import 'package:hospital/helper/flash_helper.dart';
import 'package:hospital/theme/app_colors.dart';
import '../app.dart';

abstract class BaseController<R extends BaseRepository> extends GetxController
    with Overlays {
  /// Constructor ***********************************************
  final String tag = Get.currentRoute + kNumOfNav.toString();

  ///Data & Observables ******************************************
  var loading = false.obs;
  var isEmpty = false.obs;
  var upload = false.obs;

  /// inject repo
  R? get repository;

  injectRepository() {}

  /// U need to inject a repo instance if not coming from a root , Bindings()

  // add all listeners to dispose them
  final List<StreamSubscription?> _disposableList = [];

  ///Matches on page creates
  @override
  void onInit() {
    injectRepository();
    onCreate();
    super.onInit();
  }

  ///Matches on page resume
  @override
  void onReady() {
    _observeError();
    onResume();
    super.onReady();
  }

  @override
  void dispose() {
    repository?.dispose();
    for (StreamSubscription? subscription in _disposableList) {
      subscription?.cancel();
    }
    super.dispose();
  }

  @override
  void onClose() {
    onDestroy();
    _deleteRepository();
    super.onClose();
  }

  _deleteRepository() {
    loading.close();
    if (GetInstance().isRegistered<R>(tag: tag)) {
      GetInstance().delete<R>(tag: tag);
    }
  }

  //observe error
  _observeError() {
    var subscription = repository?.errorObservable.stream.listen((event) {
      showErrorMessage(event.message);
    });
    _disposableList.add(subscription);
  }

  /// Messages
  showErrorMessage(String? msg) {
    show(msg!, kRedError);
  }

  showSuccessMessage(String msg) {
    show(msg, kGreen);
  }

  showMessage(String msg) {
    show(msg, kWarning);
  }

  show(String msg, Color color) {
    FlashHelper.showTopFlash(msg, bckColor: color);
  }

  String getLocalEnum({required String key, required Map enumMap}) {
    return enumMap[key]['label'][Get.locale!.languageCode];
  }

  Color getColorString({required String key, required Map enumMap}) {
    return Color(
        int.parse((enumMap[key]['color'] as String).replaceAll('#', '0xff')));
  }

  ///Abstract - instance  methods to do extra work after init
  onCreate() {}

  onResume() {}

  onDestroy() {}

  ///Helper methods *********************************************************************
  addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);

  stopLoading() {
    loading.value = false;
  }

  hideKeyboard() => FocusScope.of(Get.context!).requestFocus(FocusNode());

  // logout
  confirmLogout() {
    // showConfirmationDialog(body: 'confirm_logout'.tr, okCallback: doLogout);
  }

  doLogout() async {
    // await Get.find<AuthHelper>().logout();
    // Get.offAllNamed(Routes.userAuthLogin, arguments: UserType.user);
  }

  // bool isLoggedIn() => Get.find<AuthHelper>().isLoggedIn();

  bool isLoggedInWithSheet({String? title}) {
    // if (!isLoggedIn()) {
    //   // showMustLoginSheet(title: title);
    //   return false;
    // }
    return true;
  }
}
