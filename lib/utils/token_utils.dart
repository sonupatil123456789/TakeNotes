import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class TokenUtils{

  static Future generateToken(data)async {
  final jwt = JWT(data);
  return jwt.sign(SecretKey('secret passphrase'));
  }

  static Future validateToken(token)async {
    return JWT.decode(token).payload;
  }

}