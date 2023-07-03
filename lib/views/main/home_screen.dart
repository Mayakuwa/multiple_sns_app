// flutter
import 'package:first_app/details/rounded_button.dart';
import 'package:flutter/material.dart';
// models
import 'package:first_app/models/main/home_model.dart';
// constans
import 'package:first_app/constants/strings.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// domain
import 'package:first_app/domain/post/post.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final postDocs = homeModel.postDocs;
    return homeModel.postDocs.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RoundedButton(
                    onPressed: () async => homeModel.onReload(),
                    withRate: 0.85,
                    color: Colors.purple,
                    textColor: Colors.white,
                    text: reloadText),
              )
            ],
          )
        : Column(
            children: [
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      onRefresh: () async => await homeModel.onRefresh(),
                      onLoading: () async => await homeModel.onLoading(),
                      controller: homeModel.refreshController,
                      child: ListView.builder(
                          itemCount: postDocs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final doc = postDocs[index];
                            final Post post = Post.fromJson(doc.data()!);
                            return ListTile(
                              title: Text(post.text),
                            );
                          })))
            ],
          );
  }
}
