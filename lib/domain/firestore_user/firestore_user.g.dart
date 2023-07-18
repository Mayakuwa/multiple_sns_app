// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUser _$$_FirestoreUserFromJson(Map<String, dynamic> json) =>
    _$_FirestoreUser(
      uid: json['uid'] as String,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'],
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      isAdmin: json['isAdmin'] as bool,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'isAdmin': instance.isAdmin,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
