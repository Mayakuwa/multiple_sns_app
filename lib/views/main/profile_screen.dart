// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';
// components
import 'package:first_app/details/user_image.dart';
import 'package:first_app/details/rounded_button.dart';
// models
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/main/profile_model.dart';
// constants
import 'package:first_app/constants/strings.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      profileModel.croppedFile == null
          ? UserImage(lenght: 100, userImageURL: firestoreUser.userImageURL)
          : ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.file(
                profileModel.croppedFile!,
              ),
            ),
      Text(
        firestoreUser.uid,
        style: TextStyle(fontSize: 32.0),
      ),
      Text(
        'フォロー中' + firestoreUser.followingCount.toString(),
        style: TextStyle(fontSize: 32.0),
      ),
      Text(
        'フォローワー' + firestoreUser.followerCount.toString(),
        style: TextStyle(fontSize: 32.0),
      ),
      RoundedButton(
          onPressed: () async {
            await profileModel.uploadUserImage(
                currentUserDoc: mainModel.currentUserDoc);
          },
          withRate: 0.85,
          color: Colors.purple,
          textColor: Colors.white,
          text: uploadText),
    ]);
  }
}
