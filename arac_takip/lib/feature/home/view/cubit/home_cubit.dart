import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../model/car_tracking_info_model.dart';
import '../../service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(const HomeState()) {
    initalComplete();
  }
  final IHomeService homeService;

  Future<void> initalComplete() async {
    await Future.microtask(() {
      emit(const HomeState(isInitial: true));
    });
    await fetchAllRecords();
    emit(state.copyWith(selectrecords: state.records));
  }

  Future<void> fetchNewRecords() async {
    if (state.isLoading ?? false) {
      return;
    }
    _changeLoading();
    int _pageNumber = (state.pageNumber ?? 1 /* kOne.toInt() */);
    final response = await homeService.fetchAllRecords(count: ++_pageNumber * 5);
    _changeLoading();
    emit(state.copyWith(records: response, pageNumber: _pageNumber));
  }

  Future<void> fetchAllRecords() async {
    _changeLoading();
    final response = await homeService.fetchAllRecords();
    emit(state.copyWith(records: response ?? []));
    _changeLoading();
  }

  void updateList(int index, CarTrackingInfo? model) {
    if (model != null) {
      emit(state.copyWith(isUpdated: false));
      //state.records?[index].price = (model.price ?? kZero) + 300;
      emit(state.copyWith(isUpdated: true));
    }
  }

  //null ise false ata değilse tersine ata
  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
