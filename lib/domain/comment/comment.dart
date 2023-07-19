import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String uid,
    required String comment,
    required int likeCount,
    required String postCommentId,
    required int postCommentReplyCount,
    required String userName,
    required String userImageURL,
    required dynamic createdAt,
    required dynamic updatedAt,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
