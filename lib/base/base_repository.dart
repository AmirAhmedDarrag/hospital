import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/helper/callback.dart';
import 'package:hospital/model/api/error_model.dart';
import 'package:hospital/model/api/resource.dart';


abstract class BaseRepository {
  /// Use [fetch,update,create,delete] ex fetchUserData(), updatePhoneNumber(), deletePost() || action name in unique cases .. and so on.

  //Controllers needs to disabled
  final List<StreamSubscription> _disposableList = [];

  //Paging
  final pageLimit = 10;

  // For firebase pagination
  var endDocuments = false;
  DocumentSnapshot? lastDocSnap;

  //error rx
  var errorObservable = ErrorModel().obs;

  setError(ErrorModel? errorData) {
    errorObservable.value = errorData!;
  }

  //Error Handler
  Resource handleError(e) {
    if (e is SocketException) {
      return Resource.error(
          errorData: ErrorModel(message: 'no_internet_connection'.tr));
    } else if (e is FirebaseAuthException) {
      return Resource.error(
          errorData: ErrorModel(
              message: e.code == 'invalid-phone-number'
                  ? 'invalid_phone'.tr
                  : e.message));
    } else if (e is FirebaseException) {
      return Resource.error(errorData: ErrorModel(message: e.message));
    } else {
      return Resource.error(errorData: ErrorModel(message: e.toString()));
    }
  }

  /// Request methods *******************************************

  //Generic request methods
  Future<Resource> request(
      {bool pushError = true, required RequestCallback callback}) async {
    try {
      Resource resource = await callback.call();
      if (resource.isSuccess()) debugPrint("DATA = ${resource.data}");
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      return resource;
    } catch (e, stackTrace) {
      stackTrace.printInfo();
      Resource resource = handleError(e);
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      return resource;
    }
  }

  //Generic request real-time methods
  Stream<Resource> realTimeRequest(
      {bool pushError = true, required ListenerCallback callback}) async* {
    try {
      yield* callback.call();
    } catch (e, stackTrace) {
      stackTrace.printInfo();
      Resource resource = handleError(e);
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      yield resource;
    }
  }

  ///fire-store helper
  CollectionReference collection(String name) =>
      FirebaseFirestore.instance.collection(name);

  ///close controllers
  void dispose() {
    errorObservable.close();
    for (StreamSubscription? controller in _disposableList) {
      if (controller != null) controller.cancel();
    }
  }

  ///Helper methods ****
  addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);

  /// Shared Methods *******************************************************
  // Future<Resource> fetchClient(DocumentReference reference) async {
  //   return request(
  //       pushError: false,
  //       callback: () async {
  //         var response = await reference.get();
  //
  //         return Resource.success(
  //             data: Client.fromMap(response.data(), response.reference));
  //       });
  // }


  ///pagination setter
  setNextPage({required QuerySnapshot snapshot}) {
    if (snapshot.size < pageLimit) {
      endDocuments = true;
      lastDocSnap = null;
    } else {
      endDocuments = false;
      lastDocSnap = snapshot.docs[snapshot.docs.length - 1];
    }
  }

  ///reset Pagination
  resetPagination() {
    endDocuments = false;
    lastDocSnap = null;
  }
}
