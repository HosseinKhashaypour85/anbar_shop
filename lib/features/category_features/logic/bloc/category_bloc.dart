import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:online_shop/features/category_features/model/category_model.dart';
import 'package:online_shop/features/category_features/services/category_api_repository.dart';
import 'package:online_shop/features/public_features/functions/error/error_message_class.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryApiRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CallCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        CategoryModel categoryModel = await repository.callCategoryApi(event.category);
        emit(CategoryCompletedState(categoryModel: categoryModel));
      } catch (e) {
        emit(CategoryErrorState(
          error: ErrorMessageClass(errorMsg: "Unexpected Error: $e"),
        ));
      }
    });
  }
}
