// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_comment_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LikeCommentToken _$$_LikeCommentTokenFromJson(Map<String, dynamic> json) =>
    _$_LikeCommentToken(
      activeUid: json['activeUid'] as String,
      passiveUid: json['passiveUid'] as String,
      createdAt: json['createdAt'],
      postCommentRef: json['postCommentRef'],
      postCommentId: json['postCommentId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_LikeCommentTokenToJson(_$_LikeCommentToken instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'passiveUid': instance.passiveUid,
      'createdAt': instance.createdAt,
      'postCommentRef': instance.postCommentRef,
      'postCommentId': instance.postCommentId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
