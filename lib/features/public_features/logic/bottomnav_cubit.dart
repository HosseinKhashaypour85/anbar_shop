import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<int> {
  BottomnavCubit() : super(0);
  int currentIndex = 0;
  changeIndex (int index){
    emit(currentIndex = index);
  }
}
