// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reply _$$_ReplyFromJson(Map<String, dynamic> json) => _$_Reply(
      uid: json['uid'] as String,
      reply: json['reply'] as String,
      likeCount: json['likeCount'] as int,
      postRef: json['postRef'],
      postCommentRef: json['postCommentRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$$_ReplyToJson(_$_Reply instance) => <String, dynamic>{
      'uid': instance.uid,
      'reply': instance.reply,
      'likeCount': instance.likeCount,
      'postRef': instance.postRef,
      'postCommentRef': instance.postCommentRef,
      'postCommentReplyId': instance.postCommentReplyId,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'createdAt': instance.createdAt,
    };
