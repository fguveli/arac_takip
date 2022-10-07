import 'package:arac_takip/feature/home/service/home_service.dart';
import 'package:arac_takip/product/network/product_db_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IHomeService homeService;
  setUp(() {
    homeService = HomeService(DBManager());
  });

  test('fetchALlRecords', () async {
    final response = await homeService.fetchAllRecords();
    expect(response, isNotEmpty);
  });
}
