// flutter
import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flash/flash.dart';

// ViewとModelを橋渡ししてくれるよ
final createPostProvider = ChangeNotifierProvider((ref) => CreatePostModel());

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String text = '';
  void showPostDialog({required BuildContext context}) {
    context.showFlashBar(
      persistent: true,
      content: Form(
          child: TextFormField(
        controller: textEditingController,
        style: TextStyle(fontWeight: FontWeight.bold),
        onChanged: (value) => text = value,
        maxLines: 10,
      )),
      title: Text(createPostText),
      // メインの動作
      primaryActionBuilder: (context, controller, _) {
        return InkWell(
          child: Icon(Icons.send),
          onTap: () async {
            if (textEditingController.text.isNotEmpty) {
              // メインの動作
              controller.dismiss();
            } else {
              // 何もしない
              await controller.dismiss();
            }
          },
        );
      },
      // 閉じる時の動作
      negativeActionBuilder: (context, controller, _) {
        return InkWell(
          child: Icon(Icons.close),
          onTap: () async => await controller.dismiss(),
        );
      },
    );
  }
}
