import '../../model/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class SearchLoaded extends UserState {
  final List<User> users;
  SearchLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}