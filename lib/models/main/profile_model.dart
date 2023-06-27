// flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// constans
import 'package:first_app/constants/others.dart';

// ViewとModelを橋渡ししてくれるよ
final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {
  XFile? xFile;

  Future<void> pickImage() async {
    xFile = await returnXFile();
  }

  // Future<String> uploadImageAndGetURL({required String uid}) async {
  //   await print();
  // }
}
