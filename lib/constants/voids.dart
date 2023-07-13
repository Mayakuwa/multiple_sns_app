// flutter
import 'package:flutter/material.dart';
// model
import 'package:first_app/models/main_model.dart';
// packages
import 'package:flash/flash.dart';

void showFlashBar(
    {required BuildContext context,
    required MainModel mainModel,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color primaryActionColor,
    required Widget Function(BuildContext, FlashController<Object?>,
            void Function(void Function()))?
        primaryActionBuilder}) {
  context.showFlashBar(
    content: Form(
        child: TextFormField(
      controller: textEditingController,
      style: TextStyle(fontWeight: FontWeight.bold),
      onChanged: onChanged,
      maxLines: 10,
    )),
    title: Text(titleString),
    primaryActionBuilder: primaryActionBuilder,
    // 閉じる時の動作
    negativeActionBuilder: (_, controller, __) {
      return InkWell(
        child: Icon(Icons.close),
        onTap: () async => await controller.dismiss(),
      );
    },
  );
}
