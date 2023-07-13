// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constant
import 'package:first_app/constants/voids.dart' as voids;
// model
import 'package:first_app/models/main_model.dart';
// component
import 'package:first_app/constants/strings.dart';

// ViewとModelを橋渡ししてくれるよ
final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String comment = "";

  void showCommentFlashBar({
    required BuildContext context,
    required MainModel mainModel,
  }) {
    voids.showFlashBar(
        context: context,
        mainModel: mainModel,
        textEditingController: textEditingController,
        onChanged: (value) => comment = value,
        titleString: createCommentText,
        primaryActionColor: Colors.purple,
        primaryActionBuilder: (_, controller, __) {
          return InkWell(
            onTap: () async {
              if (textEditingController.text.isNotEmpty) {
                // メインの動作
                await createComment();
                await controller.dismiss();
                comment = "";
                textEditingController.text = "";
              } else {
                await controller.dismiss();
              }
            },
            child: Icon(Icons.send, color: Colors.purple),
          );
        });
  }

  Future<void> createComment() async {}
}
