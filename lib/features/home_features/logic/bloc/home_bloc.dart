import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:online_shop/features/home_features/model/all_products_home_model.dart';
import 'package:online_shop/features/home_features/services/home_api_repository.dart';

import '../../../public_features/functions/error/error_message_class.dart';
import '../../model/home_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApiRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<CallHomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        List<HomeModel> homeModel = await repository.callHomeApi();
        emit(HomeCompletedState(homeModel: homeModel));
      } on DioException catch (e) {
        emit(HomeErrorState(
          error: ErrorMessageClass(errorMsg: "Dio Error: ${e.message}"),
        ));
      } catch (e) {
        emit(HomeErrorState(
          error: ErrorMessageClass(errorMsg: "Unexpected Error: $e"),
        ));
      }
    });

    // on<CallAllProductsHomeEvent>((event, emit) async {
    //   emit(HomeLoadingState());
    //   try {
    //     List<AllProductsHomeModel> allProducts = await repository.callAllProductsHomeApi();
    //     emit(HomeCompletedState(allProductsHomeModel: allProducts, homeModel: []));
    //   } on DioException catch (e) {
    //     emit(HomeErrorState(
    //       error: ErrorMessageClass(errorMsg: "Dio Error: ${e.message}"),
    //     ));
    //   } catch (e) {
    //     emit(HomeErrorState(
    //       error: ErrorMessageClass(errorMsg: "Unexpected Error: $e"),
    //     ));
    //   }
    // });
  }
}
