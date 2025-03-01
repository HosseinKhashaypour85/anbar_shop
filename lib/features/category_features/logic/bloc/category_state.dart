part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState{}

class CategoryCompletedState extends CategoryState{
  final CategoryModel categoryModel;
  CategoryCompletedState({required this.categoryModel});
}

class CategoryErrorState extends CategoryState{
  final ErrorMessageClass error;
  CategoryErrorState({required this.error});
}

