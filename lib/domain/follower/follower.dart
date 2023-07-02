import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'follower.freezed.dart';
part 'follower.g.dart';

@freezed
abstract class Follower with _$Follower {
  // DBに保存する
  // followedUidはフォローされた人のuid,followerは、フォローした人のuid
  const factory Follower(
      {required String followedUid,
      required String followerUid,
      required dynamic createdAt}) = _Follower;
  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
}
