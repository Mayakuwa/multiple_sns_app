enum TokenType { following, likePost }

// 引数にTokenType.followingを入れるとStringの'following'がreturnされる
String returnTokenTypeString({required TokenType tokenType}) =>
    tokenType.toString().substring(10);

String followingTokenType =
    returnTokenTypeString(tokenType: TokenType.following);

String likePostTokenType = returnTokenTypeString(tokenType: TokenType.likePost);

TokenType mapToTokenType({required Map<String, dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap['tokenType'];
  if (tokenTypeString == followingTokenType) {
    return TokenType.following;
  } else {
    return TokenType.likePost;
  }
}
