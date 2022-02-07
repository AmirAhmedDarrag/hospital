import 'dart:convert';

import 'package:get_storage/get_storage.dart';

///Storage Keys
enum PreferenceKeys {userTypeFlow,keyAppLocal,keyHasClientClaims,keyUserGuide,keyClient}

class AppPreferences {
  //Data
  late GetStorage _storage;

  //init
  init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  ///App Locale **************************************************
  String? currentLocal() {
    return _storage.read(PreferenceKeys.keyAppLocal.toString()); // Language
  }

  setCurrentLocale(String? language) {
    _storage.write(PreferenceKeys.keyAppLocal.toString(), language);
  }

  ///set User Type Flow ******************************************
  setUserTypeFlow(String type){
    _storage.write(PreferenceKeys.userTypeFlow.toString(), type);
  }

  String? getUserType(){
   return _storage.read(PreferenceKeys.userTypeFlow.toString());
  }

  ///Client data *************************************************
  // setClient(Client client) {
  //
  // }
  //
  // Client? getClient() {
  // }

  ///User-Guide ***************************************************
  setTookUserGuide(bool taken) {
    _storage.write(PreferenceKeys.keyUserGuide.toString(), taken);
  }

  bool isTookUserGuide() {
    return _storage.read(PreferenceKeys.keyUserGuide.toString()) ?? false;
  }

  ///Has client claims *******************************************
  setHasClientClaims(bool taken) {
    _storage.write(PreferenceKeys.keyHasClientClaims.toString(), taken);
  }

  bool hasClientClaims() {
    return _storage.read(PreferenceKeys.keyHasClientClaims.toString()) ?? false;
  }

  ///Clear *******************************************************
  clear() async {
    String? local = currentLocal();
    String? userType = getUserType();
    bool isUserGuide = isTookUserGuide();
    bool hasClaim = hasClientClaims();
    await _storage.erase();
    setCurrentLocale(local);
    setUserTypeFlow(userType!);
    setTookUserGuide(isUserGuide);
    setHasClientClaims(hasClaim);
  }
}
