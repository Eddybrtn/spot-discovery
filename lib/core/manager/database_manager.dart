import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:spot_discovery/core/model/spot.dart';

class DatabaseManager {
  static const SPOT_STORE = "spot-store";
  static DatabaseManager instance = DatabaseManager._internal();

  factory DatabaseManager() => instance;

  Database _db;
  StoreRef<int, Map<String, dynamic>> _spotStore =
      intMapStoreFactory.store(SPOT_STORE);

  DatabaseManager._internal();

  Future<void> init() async {
    String dataDirectoryPath = (await getApplicationDocumentsDirectory()).path;
    _db = await databaseFactoryIo
        .openDatabase("$dataDirectoryPath/spot_discovery.db");
  }

  Future<void> toggleFavorite(bool isFavorite, Spot spot) =>
      isFavorite ? removeSpot(spot.id) : insertSpot(spot);

  Future<void> insertSpot(Spot spot) async =>
      await _db.transaction((transaction) async =>
          await _spotStore.record(spot.id).put(transaction, spot.toJson()));

  Future<void> removeSpot(int idSpot) async =>
      await _spotStore.record(idSpot).delete(_db);

  Future<bool> isFavorite(int idSpot) async =>
      await _spotStore.record(idSpot).exists(_db);

  Future<List<Spot>> getFavoriteSpots() async =>
      await _spotStore.find(_db).then((records) =>
          records.map((record) => Spot.fromJson(record.value)).toList());
}
