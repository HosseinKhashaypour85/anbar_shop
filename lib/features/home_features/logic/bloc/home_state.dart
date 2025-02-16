part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeCompletedState extends HomeState{
  final List<HomeModel> homeModel;
  // final List<AllProductsHomeModel> allProductsHomeModel;
  HomeCompletedState({required this.homeModel});
}

class HomeErrorState extends HomeState{
  final ErrorMessageClass error;
  HomeErrorState({required this.error});
}


