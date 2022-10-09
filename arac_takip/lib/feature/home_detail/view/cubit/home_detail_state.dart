part of 'home_detail_cubit.dart';

class HomeDetailState extends Equatable {
  const HomeDetailState({
    this.id,
    this.model,
    this.plate,
    this.fromdate,
    this.todate,
    this.takenfrom,
    this.givento,
    this.note,
  });

  final int? id;
  final String? model;
  final String? plate;
  final DateTime? fromdate;
  final DateTime? todate;
  final String? takenfrom;
  final String? givento;
  final String? note;

  @override
  List<Object?> get props => [
        plate,
        fromdate,
        todate,
        takenfrom,
        givento,
        note,
      ];

  HomeDetailState copyWith({
    final int? id,
    final String? model,
    final String? plate,
    final DateTime? fromdate,
    final DateTime? todate,
    final String? takenfrom,
    final String? givento,
    final String? note,
  }) {
    return HomeDetailState(
      id: id ?? this.id,
      model: model ?? this.model,
      plate: plate ?? this.plate,
      fromdate: fromdate ?? this.fromdate,
      todate: todate ?? this.todate,
      takenfrom: takenfrom ?? this.takenfrom,
      givento: givento ?? this.givento,
      note: note ?? this.note,
    );
  }
}
