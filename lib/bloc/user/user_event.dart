abstract class UserEvent {}

class LoadUsers extends UserEvent {
  int pageNo;
  LoadUsers(this.pageNo);
}

class SearchUsers extends UserEvent {
  final String search;
  SearchUsers(this.search);
}
