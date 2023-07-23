import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String uid,
    required String comment,
    required int likeCount,
    required dynamic postRef,
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
