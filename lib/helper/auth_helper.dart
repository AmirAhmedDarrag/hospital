import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital/util/collections.dart';
import '../main.dart';

class AuthHelper {
  ///Data ****
  bool isLoggedIn() => FirebaseAuth.instance.currentUser != null;

  bool phoneVerified() =>
      user?.phoneNumber != null && user!.phoneNumber!.isNotEmpty;

  bool emailVerified() => user != null && user!.emailVerified;

  Future<void> sendEmailVerify ()async{
    await user!.sendEmailVerification();
    return Future.value();
  }

  User? get user => FirebaseAuth.instance.currentUser;
  final String clientPersona = "client";
  final kRole = "role";

  ///Getter ***
  bool hasEmail() {
    if (user?.email != null && user!.email!.isNotEmpty) {
      return true;
    }
    for (UserInfo info in user!.providerData) {
      if (info.email != null && info.email!.isNotEmpty) {
        return true;
      }

    }
    return false;
  }

  String? providerEmail() {
    for (UserInfo info in user!.providerData) {
      // check email inside providers[facebook, google, apple]
      if (info.email != null && info.email!.isNotEmpty) {
        return info.email;
      }
    }
    return null;
  }

  String? providerPhoto() {
    for (UserInfo info in user!.providerData) {
      // check email inside providers[facebook, google, apple]
      if (info.photoURL != null && info.photoURL!.isNotEmpty) {
        return info.photoURL;
      }
    }
    return null;
  }

  //get user email
  String? getUserEmail() {
    if (user?.email != null && user!.email!.isNotEmpty) {
      return user!.email;
    } //check auth email
    for (UserInfo info in user!.providerData) {
      // check email inside providers[facebook, google, apple]
      if (info.email != null && info.email!.isNotEmpty) {
        return info.email;
      }
    }
    return null;
  }

  //fire-store clients reference
  DocumentReference clientRef() {
    return FirebaseFirestore.instance
        .collection(Collections.clients)
        .doc(user!.uid);

  }

  ///Check user personal - role **************
  Future<EUserRole> userRole() async {
    try {
      final oldToken = await user!.getIdTokenResult();
      if (_claimsType(oldToken) == EUserRole.client) return EUserRole.client;
      final idTokenResult = await user!.getIdTokenResult(true);
      return _claimsType(idTokenResult);
    } catch (e) {
      return EUserRole.other;
    }
  }

  // Returns user role depending on token claims
  EUserRole _claimsType(IdTokenResult idTokenResult) {
    if (idTokenResult.claims != null) {
      debugPrint("CLAIMS IS ${idTokenResult.claims.toString()}");
    }
    if (idTokenResult.claims == null ||
        idTokenResult.claims!.entries.isEmpty ||
        !idTokenResult.claims!.containsKey(kRole)) return EUserRole.empty;
    if (clientPersona == idTokenResult.claims![kRole]) return EUserRole.client;
    return EUserRole.other;
  }

  ///Logout
  Future<Void?> logout() async {
    await pref.clear();
    await FirebaseAuth.instance.signOut();
    return Future.value();
  }

  ///Methods & Config
  Future<EAuthType> getAuthType() async {
    await FirebaseAuth.instance.currentUser?.reload();
    return user == null ? EAuthType.signIn : EAuthType.link;
  }
}

/// USER TYPES ********************************
enum EUserRole { client, agent, empty, other }

/// To decide linking or auth with credentials
enum EAuthType { signIn, link }
