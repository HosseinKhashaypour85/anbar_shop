part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}
class CallHomeEvent extends HomeEvent{}
class CallAllProductsHomeEvent extends HomeEvent{}
