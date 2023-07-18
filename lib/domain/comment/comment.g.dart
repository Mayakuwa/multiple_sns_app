// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      uid: json['uid'] as String,
      comment: json['comment'] as String,
      likeCount: json['likeCount'] as int,
      postCommentId: json['postCommentId'] as String,
      postCommentReplyCount: json['postCommentReplyCount'] as int,
      userName: json['userName'] as String,
      userImaheURL: json['userImaheURL'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'comment': instance.comment,
      'likeCount': instance.likeCount,
      'postCommentId': instance.postCommentId,
      'postCommentReplyCount': instance.postCommentReplyCount,
      'userName': instance.userName,
      'userImaheURL': instance.userImaheURL,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
