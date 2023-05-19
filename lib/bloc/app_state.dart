import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../data/model/user.dart';

abstract class UserState extends Equatable {}

// Data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

// Data loaded state
class UserLoadedState extends UserState {
  final List<User> users;
  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

// Data error state
class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
