import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_discovery/core/manager/database_manager.dart';
import 'package:spot_discovery/core/manager/spot_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';

class SpotDetailBloc extends Cubit<Spot> {
  Spot _spot;
  bool isFavorite = false;

  SpotDetailBloc(this._spot) : super(_spot);

  Future<void> loadSpotDetails() async =>
      _spot = await SpotManager().getSpot(_spot.id);

  Future<void> loadFavoriteStatus() async =>
      isFavorite = await DatabaseManager().isFavorite(_spot.id);

  void toggleFavorite() async {
    await DatabaseManager().toggleFavorite(isFavorite, _spot);
    isFavorite = !isFavorite;
  }
}
