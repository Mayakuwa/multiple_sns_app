// flutter
import 'package:first_app/domain/post/post.dart';
import 'package:flutter/material.dart';
// models
import 'package:first_app/models/main/home_model.dart';
// constans
import 'package:first_app/constants/strings.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final postDocs = homeModel.postDocs;
    return ListView.builder(
        itemCount: postDocs.length,
        itemBuilder: (BuildContext context, int index) {
          final doc = postDocs[index];
          final Post post = Post.fromJson(doc.data()!);
          return ListTile(
            title: Text(post.text),
          );
        });
  }
}
