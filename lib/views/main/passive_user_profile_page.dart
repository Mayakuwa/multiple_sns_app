// flutter
import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({Key? key, required this.passiveUser});

  @override
  final FirestoreUser passiveUser;
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(profileTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(child: Text(passiveUser.uid))],
        ));
  }
}
