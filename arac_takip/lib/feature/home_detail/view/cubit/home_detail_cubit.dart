import 'package:arac_takip/product/constant/application_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../home/model/car_tracking_info_model.dart';
import '../../service/home_detail_service.dart';

part 'home_detail_state.dart';

class HomeDetailCubit extends Cubit<HomeDetailState> {
  final int? id;
  HomeDetailCubit(this.id) : super(const HomeDetailState()) {
    fetchItem();
  }

  //null ise false ata değilse tersine ata
  /* void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  } */

  void fetchItem() async {
    if (state.id == null) {
      return;
    }
    var response = await ApplicationConstant.dbHelper.fetch(id!);
    emit(state.copyWith(
      id: response.id,
      model: response.model,
      plate: response.plate,
      fromdate: response.fromdate,
      todate: response.todate,
      takenfrom: response.takenfrom,
      givento: response.givento,
      note: response.note,
    ));
  }

  void _changeFromDateTime() {
    emit(state.copyWith(fromdate: state.fromdate));
  }

  void _changeToDateTime() {
    emit(state.copyWith(todate: state.todate));
  }
}
