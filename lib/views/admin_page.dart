// flutter
import 'package:first_app/models/admin_model.dart';
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// constants
import 'package:first_app/constants/strings.dart';
// componetsn
import 'package:first_app/details/rounded_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPage extends ConsumerWidget {
  AdminPage({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AdminModel adminModel = ref.watch(adminProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(adminTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedButton(
                onPressed: () async => adminModel.admin(
                    currenyUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser),
                withRate: 0.85,
                color: Colors.purple,
                textColor: Colors.white,
                text: adminTitle),
          )
        ],
      ),
    );
  }
}
