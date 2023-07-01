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
      email: json['email'] as String,
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'email': instance.email,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
