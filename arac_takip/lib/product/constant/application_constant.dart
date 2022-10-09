import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';
import 'package:arac_takip/product/network/product_db_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ApplicationConstant {
  static ApplicationConstant? _instance;
  static ApplicationConstant get instance {
    _instance ??= ApplicationConstant._init();
    return _instance!;
  }

  ApplicationConstant._init();

  //dbHelper olarak database objesini bir kere oluşturuyorum
  static DatabaseHelper dbHelper = DatabaseHelper();
}

double kZero = 0;
double kOne = 1;

List<String> iconList = [
  "assets/images/clio",
  "assets/images/polo",
  "assets/images/c3",
];

var carList = [
  "Clio",
  "Polo",
  "C3",
];

class DatabaseHelper {
  static DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;

  final String tableItem = "items";
  final String columnId = "id";
  final String columnItemName = "item_name";
  final String columnDateCreated = "date_created";

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get db async => _db ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "GVLCARINFO.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  //Burası tablomuz ilk defa create olacağı zaman veritabanının yapacağı işlem.
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE GVLCARINFO (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, model TEXT, plate TEXT, fromdate real, todate real,  takenfrom TEXT, givento TEXT, isAllDay INTEGER, note TEXT)");
  }

  //Kaydetmek için kullanılacak yapı
  Future<int> saveCalendarLog(CarTrackingInfo record) async {
    var dbClient = await db;
    int res = await dbClient.insert('GVLCARINFO', record.toJson());
    return res;
  }

  Future<int> updateCalendarLog(CarTrackingInfo calendar) async {
    var dbClient = await db;
    int res = await dbClient.update(
      'GVLCARINFO',
      calendar.toJson(),
      where: 'id = ?',
      whereArgs: [calendar.id],
    );
    return res;
  }

  Future<int> deleteCalendarLog(CarTrackingInfo calendar) async {
    var dbClient = await db;
    int res = await dbClient.delete(
      'GVLCARINFO',
      where: 'id = ?',
      whereArgs: [calendar.id],
    );
    return res;
  }

  Future<List<CarTrackingInfo>> getCalendarLogs() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient.rawQuery('SELECT * FROM GVLCARINFO');
    return list.map((e) => CarTrackingInfo.fromJson(e)).toList();
  }

  Future<CarTrackingInfo> fetch(int? id) async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient.rawQuery('SELECT * FROM GVLCARINFO WHERE id = $id');
    return CarTrackingInfo.fromJson(list[0]);
  }
}
