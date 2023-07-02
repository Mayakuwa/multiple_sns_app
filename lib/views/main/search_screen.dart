// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:first_app/models/main/search_model.dart';
import 'package:first_app/models/main_model.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
// routes
import 'package:first_app/constants/routes.dart' as routes;

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchModel searchModel = ref.watch(searchProvider);
    return Container(
        child: ListView.builder(
            itemCount: searchModel.users.length,
            itemBuilder: ((context, index) {
              final FirestoreUser firestoreUser = searchModel.users[index];
              return ListTile(
                title: Text(firestoreUser.uid),
                onTap: () => routes.toPassiveUserProfilePage(
                    context: context,
                    passiveUser: firestoreUser,
                    mainModel: mainModel),
              );
            })));
  }
}
