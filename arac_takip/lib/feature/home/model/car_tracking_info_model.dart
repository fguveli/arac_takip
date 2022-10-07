class CarTrackingInfo {
  String? model;
  String? plate;
  DateTime? fromdate;
  DateTime? todate;
  String? takenfrom;
  String? givento;

  CarTrackingInfo({this.model, this.plate, this.fromdate, this.todate, this.takenfrom, this.givento});

  CarTrackingInfo.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    plate = json['plate'];
    fromdate = DateTime.fromMicrosecondsSinceEpoch(json['fromdate'].toInt() * 1000);
    todate = DateTime.fromMicrosecondsSinceEpoch(json['todate'].toInt() * 1000);
    takenfrom = json['takenfrom'];
    givento = json['givento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = model;
    data['plate'] = plate;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['takenfrom'] = takenfrom;
    data['givento'] = givento;
    return data;
  }
}
