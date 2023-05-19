import 'package:the_bloc_app/bloc/app_event.dart';
import 'package:the_bloc_app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bloc_app/data/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
