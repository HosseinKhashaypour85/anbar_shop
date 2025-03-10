import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../public_features/functions/error/error_exception.dart';
import '../../public_features/functions/error/error_message_class.dart';
import '../model/search_model.dart';
import '../services/search_api_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchApiRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<CallSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final List<SearchModel> searchModel = await repository.callSearchApi();
        print("Search Successful: ${searchModel.length} items found");
        emit(SearchCompletedState(searchModel: searchModel));
      } on DioException catch (e) {
        print("Dio Exception: ${e.message}");
        emit(SearchErrorState(
            error: ErrorMessageClass(
                errorMsg: ErrorExceptions().fromError(e))));
      } catch (e) {
        print("Unexpected Error: $e");
        emit(SearchErrorState(
            error: ErrorMessageClass(errorMsg: "Unknown error occurred")));
      }
    });
  }
}