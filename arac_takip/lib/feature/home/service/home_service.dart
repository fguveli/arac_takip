import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';

import '../../../product/network/product_db_manager.dart';

abstract class IHomeService {
  late final DBManager _dbManager;
  IHomeService(DBManager dbManager) : _dbManager = dbManager;

  Future<List<CarTrackingInfo>?> fetchAllRecords({int count = 5});
}

class HomeService extends IHomeService {
  HomeService(DBManager dbManager) : super(dbManager);

  @override
  Future<List<CarTrackingInfo>?> fetchAllRecords({int count = 5}) async {
    final response = await _dbManager.selectRecords();

    return response;
  }
}
