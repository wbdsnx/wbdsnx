
class User {
  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    email = map["email"];
    if (map.containsKey("token")) {
      token = new AuthorizationToken.fromMap(map["token"]);
    }
  }

  int id;
  String username;
  int age;
  int sex;
  String phone;
  String email;
  double height;
  double weight;
  String state;
  String province;
  String city;
  String address;
  AuthorizationToken token;
  bool get isAuthenticated => token != null && !token.isExpired;

  Map<String, dynamic> asMap() =>
      {
        "id": id,
        "email": email,
        "token": token.asMap()
      };
}

class AuthorizationToken {
  AuthorizationToken.fromMap(Map<String, dynamic> map) {
    accessToken = map["access_token"];
    refreshToken = map["refresh_token"];

    if (map.containsKey("expires_in")) {
      expiresAt = new DateTime.now().add(new Duration(seconds: map["expires_in"]));
    } else if (map.containsKey("expiresAt")) {
      expiresAt = DateTime.parse(map["expiresAt"]);
    }
  }
  String accessToken;
  String refreshToken;
  DateTime expiresAt;

  String get authorizationHeaderValue => "Bearer $accessToken";

  bool get isExpired =>
      expiresAt.difference(new DateTime.now()).inSeconds < 0;

  Map<String, dynamic> asMap() =>
      {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expiresAt": expiresAt.toIso8601String()
      };
}