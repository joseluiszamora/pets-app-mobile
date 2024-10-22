import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  final String id;
  final String document;
  final String firstName;
  final String lastName;
  final String phone;
  final String token;

  const User({
    required this.id,
    required this.document,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.token,
  });

  User.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        document = json['document'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        phone = json['phone'],
        token = json['token'];

  static const empty = User(
      id: '', document: '', firstName: '', lastName: '', phone: '', token: '');

  @override
  String toString() =>
      'User { id: $id, document: $document, firstName: $firstName, lastName: $lastName, phone: $phone, token: $token }';

  static User fromJson(jsonDecode) {
    return User.fromjson(jsonDecode);
  }

  // Decode User from TOKEN
  static User userFromToken(String token) {
    Map? userPayload = JwtDecoder.decode(token);
    return User(
        id: userPayload['id'].toString(),
        document: userPayload['dni'],
        firstName: userPayload['first_name'],
        lastName: userPayload['last_name'],
        phone: userPayload['cellphone'].toString(),
        token: token);
  }
}

User testUser() {
  return const User(
      id: 'id',
      document: 'demo@mail.bo',
      firstName: 'jsoe luis',
      lastName: 'zamora',
      phone: 'phone',
      token: 'TOKEN 123');
}
