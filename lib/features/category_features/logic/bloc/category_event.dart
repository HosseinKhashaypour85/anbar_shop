part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CallCategoryEvent extends CategoryEvent{
  final String category;
  CallCategoryEvent(this.category);
}
