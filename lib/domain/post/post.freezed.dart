// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get postId => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get postCommentCount => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  List<String> get hashTags => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  dynamic get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String postId,
      int likeCount,
      String text,
      int postCommentCount,
      String uid,
      String imageURL,
      List<String> hashTags,
      String userName,
      String userImageURL,
      dynamic createdAt,
      dynamic updatedAt});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? likeCount = null,
    Object? text = null,
    Object? postCommentCount = null,
    Object? uid = null,
    Object? imageURL = null,
    Object? hashTags = null,
    Object? userName = null,
    Object? userImageURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentCount: null == postCommentCount
          ? _value.postCommentCount
          : postCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      hashTags: null == hashTags
          ? _value.hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$_PostCopyWith(_$_Post value, $Res Function(_$_Post) then) =
      __$$_PostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String postId,
      int likeCount,
      String text,
      int postCommentCount,
      String uid,
      String imageURL,
      List<String> hashTags,
      String userName,
      String userImageURL,
      dynamic createdAt,
      dynamic updatedAt});
}

/// @nodoc
class __$$_PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res, _$_Post>
    implements _$$_PostCopyWith<$Res> {
  __$$_PostCopyWithImpl(_$_Post _value, $Res Function(_$_Post) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? likeCount = null,
    Object? text = null,
    Object? postCommentCount = null,
    Object? uid = null,
    Object? imageURL = null,
    Object? hashTags = null,
    Object? userName = null,
    Object? userImageURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Post(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentCount: null == postCommentCount
          ? _value.postCommentCount
          : postCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      hashTags: null == hashTags
          ? _value._hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Post implements _Post {
  const _$_Post(
      {required this.postId,
      required this.likeCount,
      required this.text,
      required this.postCommentCount,
      required this.uid,
      required this.imageURL,
      required final List<String> hashTags,
      required this.userName,
      required this.userImageURL,
      required this.createdAt,
      required this.updatedAt})
      : _hashTags = hashTags;

  factory _$_Post.fromJson(Map<String, dynamic> json) => _$$_PostFromJson(json);

  @override
  final String postId;
  @override
  final int likeCount;
  @override
  final String text;
  @override
  final int postCommentCount;
  @override
  final String uid;
  @override
  final String imageURL;
  final List<String> _hashTags;
  @override
  List<String> get hashTags {
    if (_hashTags is EqualUnmodifiableListView) return _hashTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashTags);
  }

  @override
  final String userName;
  @override
  final String userImageURL;
  @override
  final dynamic createdAt;
  @override
  final dynamic updatedAt;

  @override
  String toString() {
    return 'Post(postId: $postId, likeCount: $likeCount, text: $text, postCommentCount: $postCommentCount, uid: $uid, imageURL: $imageURL, hashTags: $hashTags, userName: $userName, userImageURL: $userImageURL, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Post &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.postCommentCount, postCommentCount) ||
                other.postCommentCount == postCommentCount) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            const DeepCollectionEquality().equals(other._hashTags, _hashTags) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      likeCount,
      text,
      postCommentCount,
      uid,
      imageURL,
      const DeepCollectionEquality().hash(_hashTags),
      userName,
      userImageURL,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostCopyWith<_$_Post> get copyWith =>
      __$$_PostCopyWithImpl<_$_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {required final String postId,
      required final int likeCount,
      required final String text,
      required final int postCommentCount,
      required final String uid,
      required final String imageURL,
      required final List<String> hashTags,
      required final String userName,
      required final String userImageURL,
      required final dynamic createdAt,
      required final dynamic updatedAt}) = _$_Post;

  factory _Post.fromJson(Map<String, dynamic> json) = _$_Post.fromJson;

  @override
  String get postId;
  @override
  int get likeCount;
  @override
  String get text;
  @override
  int get postCommentCount;
  @override
  String get uid;
  @override
  String get imageURL;
  @override
  List<String> get hashTags;
  @override
  String get userName;
  @override
  String get userImageURL;
  @override
  dynamic get createdAt;
  @override
  dynamic get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PostCopyWith<_$_Post> get copyWith => throw _privateConstructorUsedError;
}
