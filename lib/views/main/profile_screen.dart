// flutter
import 'package:first_app/constants/strings.dart';
import 'package:first_app/details/rounded_button.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/models/main/profile_model.dart';
import 'package:flutter/material.dart';
// components
import 'package:first_app/details/user_image.dart';
// models
import 'package:first_app/models/main_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final int followerCount = firestoreUser.followerCount;
    final int plusOneFollowerCount = firestoreUser.followerCount + 1;
    final bool isFollowing =
        mainModel.followingUids.contains(firestoreUser.uid);
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
        'フォロー中' + firestoreUser.followingCount.toString(),
        style: TextStyle(fontSize: 32.0),
      ),
      Text(
        isFollowing
            ? 'フォローワー' + plusOneFollowerCount.toString()
            : 'フォローワー' + followerCount.toString(),
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
      SizedBox(height: 32.0),
      isFollowing
          ? RoundedButton(
              onPressed: () => profileModel.unfollow(
                  mainMode: mainModel, passiveFirestoreUser: firestoreUser),
              withRate: 0.85,
              color: Colors.purple,
              textColor: Colors.white,
              text: 'アンフォローする')
          : RoundedButton(
              onPressed: () => profileModel.follow(
                  mainModel: mainModel, passiveFirestoreUser: firestoreUser),
              withRate: 0.85,
              color: Colors.purple,
              textColor: Colors.white,
              text: 'フォロー'),
    ]);
  }
}
