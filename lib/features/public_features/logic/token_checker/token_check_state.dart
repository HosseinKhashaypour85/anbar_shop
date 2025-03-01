part of 'token_check_cubit.dart';

@immutable
sealed class TokenCheckState {}


class TokenCheckInitial extends TokenCheckState {}
class TokenCheckIsLogedState extends TokenCheckState {}
class TokenCheckIsNotLogedState extends TokenCheckState {}