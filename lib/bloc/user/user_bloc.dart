import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_userapp/bloc/user/user_event.dart';
import 'package:new_userapp/bloc/user/user_state.dart';

import '../../fetchData/fetch_data.dart';
import '../../model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;
  List<User> users = [];

  UserBloc(this.userRepo) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      try {
        final users = await userRepo.fetchUsers(event.pageNo);
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<SearchUsers>((event, emit) async {
      try {
        final results = await userRepo.searchAllUsers(event.search);
        emit(SearchLoaded(results));
      } catch (e) {
        emit(UserError('Search failed: $e'));
      }
    });
  }
}