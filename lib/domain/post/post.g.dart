// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      postId: json['postId'] as String,
      likeCount: json['likeCount'] as int,
      text: json['text'] as String,
      uid: json['uid'] as String,
      imageURL: json['imageURL'] as String,
      hashTags:
          (json['hashTags'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'likeCount': instance.likeCount,
      'text': instance.text,
      'uid': instance.uid,
      'imageURL': instance.imageURL,
      'hashTags': instance.hashTags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
