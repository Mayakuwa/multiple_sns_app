// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      uid: json['uid'] as String,
      comment: json['comment'] as String,
      likeCount: json['likeCount'] as int,
      postRef: json['postRef'],
      postCommentId: json['postCommentId'] as String,
      postCommentReplyCount: json['postCommentReplyCount'] as int,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'comment': instance.comment,
      'likeCount': instance.likeCount,
      'postRef': instance.postRef,
      'postCommentId': instance.postCommentId,
      'postCommentReplyCount': instance.postCommentReplyCount,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
