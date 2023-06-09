import 'dart:convert';

import 'package:http/http.dart';

import '../model/user.dart';

class UserService {
  String endpoint = 'https://reqres.in/api/users?page=2';
  Future<List<User>> getUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => User.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
