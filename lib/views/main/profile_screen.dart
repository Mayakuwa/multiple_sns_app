// flutter
import 'package:first_app/details/rounded_button.dart';
import 'package:first_app/models/main/profile_model.dart';
import 'package:flutter/material.dart';
// components
import 'package:first_app/details/user_image.dart';
// models
import 'package:first_app/models/main_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key, required this.mainmodel});
  final MainModel mainmodel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      profileModel.xFile == null
          ? UserImage(
              lenght: 100, userImageURL: mainmodel.firestoreUser.userImageURL)
          : Text('loading'),
      RoundedButton(
          onPressed: () async {
            // await profileModel.uploadImage();
          },
          withRate: 0.85,
          color: Colors.purple,
          textColor: Colors.white,
          text: 'upload')
    ]);
  }
}