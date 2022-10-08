import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../home/model/car_tracking_info_model.dart';
import '../../service/home_detail_service.dart';

part 'home_detail_state.dart';

class HomeCubit extends Cubit<HomeDetailStat> {
  HomeCubit(this.homeDetailService) : super(const HomeDetailStat()) {}
  final IHomeDetailService homeDetailService;

  //null ise false ata değilse tersine ata
  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
