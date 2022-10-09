//Burada DB Manager'ımızı oluşturacağız
//DB Manager classı db'ye istek atıp oradan cevap alan bir class olacak. Selectleri
//buranın içine atacağız
import 'dart:convert';
import 'dart:io';

import 'package:arac_takip/product/constant/application_constant.dart';

import '../../feature/home/model/car_tracking_info_model.dart';

class DBManager {
  Future<List<CarTrackingInfo>?> selectRecords() async {
    var json = '''
    [
      {
        "model": "Clio",
        "plate": "34 EZC 373",
        "fromdate": 1664582400,
        "todate": 1667260799,
        "takenfrom": "Ali Yılmaz",
        "givento": "İzzet Gök"
    },

    {
        "model": "Polo",
        "plate": "34 CNN 994",
        "fromdate": 1665006245,
        "todate": 1665179045,
        "takenfrom": "Mustafa Akkuş",
        "givento": "Mustafa Akkuş"
    }
    ]
    ''';
    ApplicationConstant.dbHelper.getCalendarLogs();
    final parsed = jsonDecode(json);
    //sleep(const Duration(seconds: 2));
    var myList = parsed.map<CarTrackingInfo>((json) => CarTrackingInfo.fromJson(json)).toList();
    return myList;
  }

  selectRecord(int id) {
    var fetchedInfo = ApplicationConstant.dbHelper.fetch(id);
    return fetchedInfo;
  }
}
