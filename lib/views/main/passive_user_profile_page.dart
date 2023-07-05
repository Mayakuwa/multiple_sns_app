// flutter
import 'package:first_app/constants/strings.dart';
import 'package:first_app/models/passive_user_profile_model.dart';
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
// components
import 'package:first_app/details/rounded_button.dart';
import 'package:first_app/details/user_image.dart';
// models
// models
import 'package:first_app/models/main_model.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage(
      {Key? key, required this.passiveUser, required this.mainModel});

  @override
  final FirestoreUser passiveUser;
  final MainModel mainModel;
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);
    final bool isFollowing = mainModel.followingUids.contains(passiveUser.uid);
    final int followerCount = passiveUser.followerCount;
    final int plusOneFollowerCount = passiveUser.followerCount + 1;
    return Scaffold(
        appBar: AppBar(
          title: Text(profileTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImage(lenght: 100, userImageURL: passiveUser.userImageURL),
            Center(child: Text(passiveUser.uid)),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'フォロー中' + passiveUser.followingCount.toString(),
                  style: TextStyle(fontSize: 32.0),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                isFollowing
                    ? 'フォローワー' + plusOneFollowerCount.toString()
                    : 'フォローワー' + followerCount.toString(),
                style: TextStyle(fontSize: 32.0),
              ),
            ),
            isFollowing
                ? RoundedButton(
                    onPressed: () => passiveUserProfileModel.unfollow(
                        mainModel: mainModel, passiveUser: passiveUser),
                    withRate: 0.85,
                    color: Colors.purple,
                    textColor: Colors.white,
                    text: 'アンフォローする')
                : RoundedButton(
                    onPressed: () => passiveUserProfileModel.follow(
                        mainModel: mainModel, passiveUser: passiveUser),
                    withRate: 0.85,
                    color: Colors.purple,
                    textColor: Colors.white,
                    text: 'フォロー'),
          ],
        ));
  }
}
