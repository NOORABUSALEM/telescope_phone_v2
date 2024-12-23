import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit() : super(const SearchBarHide('')) {
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
  }

  late final TextEditingController searchController;

  void _onSearchChanged() {
    updateSearchQuery(searchController.text);
  }

  void show() {
    emit(SearchBarShow(state.searchQuery));
  }

  void hide() {
    emit(SearchBarHide(state.searchQuery));
  }

  void updateSearchQuery(String query) {
    emit(SearchBarShow(query));
  }

  void clearSearch() {
    searchController.clear();
    emit(const SearchBarShow(''));
  }
}
