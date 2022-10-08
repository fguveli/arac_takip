part of 'home_detail_cubit.dart';

class HomeDetailStat extends Equatable {
  const HomeDetailStat(
      {this.records,
      this.isUpdated = false,
      this.isLoading,
      this.selectrecords,
      this.categories,
      this.isInitial = false,
      this.pageNumber});

  final List<CarTrackingInfo>? records;
  final List<CarTrackingInfo>? selectrecords;
  final bool? isLoading;
  final List<String>? categories;

  final bool isUpdated;

  final bool isInitial;
  final int? pageNumber;

  @override
  List<Object?> get props => [records, isLoading, categories, pageNumber, isUpdated, selectrecords];

  HomeDetailStat copyWith(
      {List<CarTrackingInfo>? records,
      List<CarTrackingInfo>? selectrecords,
      bool? isLoading,
      List<String>? categories,
      bool? isUpdated,
      int? pageNumber}) {
    return HomeDetailStat(
        records: records ?? this.records,
        isUpdated: isUpdated ?? this.isUpdated,
        selectrecords: selectrecords ?? this.selectrecords,
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
        pageNumber: pageNumber ?? this.pageNumber);
  }
}
