part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchCompletedState extends SearchState {
  final List<SearchModel> searchModel;
  SearchCompletedState({required this.searchModel});
}

class SearchErrorState extends SearchState {
  final ErrorMessageClass error;
  SearchErrorState({required this.error});
}
