class CarTrackingInfo {
  int? id;
  String? model;
  String? plate;
  DateTime? fromdate;
  DateTime? todate;
  String? takenfrom;
  String? givento;
  String? note;

  CarTrackingInfo({this.id, this.model, this.plate, this.fromdate, this.todate, this.takenfrom, this.givento, this.note});

  CarTrackingInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    plate = json['plate'];
    fromdate = DateTime.fromMicrosecondsSinceEpoch(json['fromdate'].toInt() * 1000);
    todate = DateTime.fromMicrosecondsSinceEpoch(json['todate'].toInt() * 1000);
    takenfrom = json['takenfrom'];
    givento = json['givento'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['model'] = model;
    data['plate'] = plate;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['takenfrom'] = takenfrom;
    data['givento'] = givento;
    data['note'] = note;
    return data;
  }
}
