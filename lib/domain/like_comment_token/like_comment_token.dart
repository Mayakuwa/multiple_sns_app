import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'like_comment_token.freezed.dart';
part 'like_comment_token.g.dart';

@freezed
abstract class LikeCommentToken with _$LikeCommentToken {
  // DBに保存する
  // 自分が投稿にいいねしたことの印
  const factory LikeCommentToken(
      {required String activeUid,
      required String passiveUid,
      required dynamic createdAt,
      required dynamic postCommentRef,
      required String postCommentId,
      required String tokenId,
      required String tokenType}) = _LikeCommentToken;
  factory LikeCommentToken.fromJson(Map<String, dynamic> json) =>
      _$LikeCommentTokenFromJson(json);
}
