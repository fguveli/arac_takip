import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';

import '../../../product/network/product_db_manager.dart';

abstract class IHomeDetailService {
  late final DBManager _dbManager;
  IHomeDetailService(DBManager dbManager) : _dbManager = dbManager;

  Future<List<CarTrackingInfo>?> fetchAllRecords({int count = 5});
}

class HomeDetailService extends IHomeDetailService {
  HomeDetailService(DBManager dbManager) : super(dbManager);

  @override
  Future<List<CarTrackingInfo>?> fetchAllRecords({int count = 5}) async {
    final response = await _dbManager.selectRecords();

    return response;
  }

  Future<List<CarTrackingInfo>?> fetchRecord({required int id}) async {
    final response = await _dbManager.selectRecord(id);

    return response;
  }
}
