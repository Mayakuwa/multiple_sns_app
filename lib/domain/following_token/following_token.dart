import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'following_token.freezed.dart';
part 'following_token.g.dart';

@freezed
abstract class FollowingToken with _$FollowingToken {
  // DBに保存する
  // 自分がフォローしたユーザのtoken
  const factory FollowingToken(
      {required String passiveUid,
      required dynamic createdAt,
      required String tokenId}) = _FollowingToken;
  factory FollowingToken.fromJson(Map<String, dynamic> json) =>
      _$FollowingTokenFromJson(json);
}
