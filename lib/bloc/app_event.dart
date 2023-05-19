import 'package:equatable/equatable.dart';

import '../data/model/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoadedUserEvent extends UserEvent {
  final List<User> users;
  const LoadedUserEvent(this.users);

  @override
  List<Object?> get props => [users];
}
