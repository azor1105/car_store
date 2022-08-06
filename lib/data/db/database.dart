import 'package:lesson_task/models/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {
  static final LocalDataBase getInstance = LocalDataBase._init();
  LocalDataBase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("favourites.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final String totalPath = join(dbPath, fileName);
    return await openDatabase(totalPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER NOT NULL";

    /// Creating todo table
    await db.execute('''
    CREATE TABLE cars (
    id $idType,
    car_model $textType,
    company_id $intType,
    logo $textType,
    established_year $intType,
    average_price $intType
    )
    ''');
  }

  static Future<int> insertCar({required CarModel carModel}) async {
    final db = await getInstance.database;
    final id = await db.insert("cars", {
      "average_price" : carModel.price,
      "established_year": carModel.establishedYear,
      "car_model": carModel.carModel,
      "company_id": carModel.companyId,
      "logo": carModel.logo
    });
    return id;
  }

  static Future<List<CarModel>> getFavouriteCars() async {
    final db = await getInstance.database;
    final cars = await db.query('cars');
    return cars.map((e) => CarModel.fromJson(e)).toList();
  }

  static Future<int> deleteFavouriteCarById(int id) async {
    final db = await getInstance.database;
    var t = await db.delete('cars',
        where: "id=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }
}
