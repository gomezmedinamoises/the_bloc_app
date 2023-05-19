import 'package:the_bloc_app/data/model/user.dart';
import 'package:the_bloc_app/data/network/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  Future<List<User>> getUsers() {
    return _userService.getUsers();
  }
}
