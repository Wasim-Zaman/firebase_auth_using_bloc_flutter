import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<bool> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDDWgdNsBAS942UIa4ShSw2jBiGju2FJqY';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseBody = json.decode(response.body);
      if (responseBody['error'] == null) {
        // handle the error.
        print(
            '****** Try Bloc Error: ${responseBody['error']['message']} ******');
        return false;
      }
      print('****** Response Body: $responseBody ******');

      // get the token from the response body.
      _token = responseBody['idToken'];

      // get the user id from the response body.
      _userId = responseBody['localId'];

      // get the expiry date from the response body.
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );
      print('****** User Logged In ******');
      return true;
    } catch (error) {
      print('****** Catch Bloc Error: $error ******');
      return false;
    }
    // print(json.decode(response.body));
  }

  Future<bool> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<bool> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
