// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
// constans
import 'package:first_app/constants/others.dart';

// ViewとModelを橋渡ししてくれるよ
final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  XFile? xFile;

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String filename = returnJpgFileName();
    final Reference storageRef = await FirebaseStorage.instance
        .ref()
        .child("user")
        .child(uid)
        .child(filename);
    // users/uid/ファイル名にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名のURLを取得している
    return await storageRef.getDownloadURL();
  }

  Future<void> uploadUserImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    // 端末上にある写真を変換したのがXfile
    xFile = await returnXFile();
    // Xfileのパス。どこにあるのかを取得
    final File file = File(xFile!.path);
    final uid = currentUserDoc.id;
    final String url = await uploadImageAndGetURL(uid: uid, file: file);
    // 現在ログイン中のユーザのリファレンスを取得
    await currentUserDoc.reference.update({'userImageURL': url});
    notifyListeners();
  }
}
