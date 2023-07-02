// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Follower _$$_FollowerFromJson(Map<String, dynamic> json) => _$_Follower(
      followedUid: json['followedUid'] as String,
      followerUid: json['followerUid'] as String,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$$_FollowerToJson(_$_Follower instance) =>
    <String, dynamic>{
      'followedUid': instance.followedUid,
      'followerUid': instance.followerUid,
      'createdAt': instance.createdAt,
    };
