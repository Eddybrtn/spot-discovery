import 'package:flutter/material.dart';
import 'package:spot_discovery/core/manager/database_manager.dart';
import 'package:spot_discovery/core/manager/spot_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';

class SpotDetailViewModel extends ChangeNotifier {
  Spot _spot;
  bool _isLoading = false;
  bool _isFavorite = false;

  Spot get spot => _spot;

  bool get isLoading => _isLoading;

  bool get isFavorite => _isFavorite;

  SpotDetailViewModel(this._spot) {
    loadData();
  }

  void loadData() async {
    _isLoading = true;
    notifyListeners();

    var results = await Future.wait([
      SpotManager().getSpot(_spot.id),
      DatabaseManager().isFavorite(_spot.id)
    ]);
    _spot = results[0];
    _isFavorite = results[1];

    _isLoading = false;
    notifyListeners();
  }

  bool hasFetchedSpotDetail() => _spot.description != null;

  void toggleFavorite() async {
    try {
      await DatabaseManager().toggleFavorite(isFavorite, _spot);
      _isFavorite = !_isFavorite;
      notifyListeners();
    } catch (e, stack) {
      print(stack);
    }
  }
}
