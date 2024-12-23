part of 'search_bar_cubit.dart';

@immutable
sealed class SearchBarState {
  final String searchQuery;
  const SearchBarState(this.searchQuery);
}

final class SearchBarShow extends SearchBarState {
  const SearchBarShow(String searchQuery) : super(searchQuery);
}

final class SearchBarHide extends SearchBarState {
  const SearchBarHide(String searchQuery) : super(searchQuery);
}