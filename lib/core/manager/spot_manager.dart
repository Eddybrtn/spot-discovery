import 'dart:core';
import 'dart:math';

import 'package:spot_discovery/core/manager/api_manager.dart';
import 'package:spot_discovery/core/manager/database_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';
import 'package:spot_discovery/core/model/spot_comment.dart';

class SpotManager {
  List<Spot> spots;

  static final SpotManager _instance = SpotManager._internal();

  factory SpotManager() => _instance;

  SpotManager._internal();

  /// Charge et renvoie la liste complète de spots
  Future<List<Spot>> loadSpots() async {
    // Calling API
    try {
      var response = await ApiManager().getAllSpots();
      if (response != null && response.data != null) {
        // Mapping data
        spots = List<Map<String, dynamic>>.from(response.data["data"])
            .map((json) => Spot.fromJson(json))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return spots;
  }

  Future<List<Spot>> loadFavoriteSpots() async =>
      await DatabaseManager().getFavoriteSpots();

  /// Renvoie un spot aléatoire de la liste pré-chargée
  Spot getRandomSpot() {
    if (spots != null && spots.isNotEmpty) {
      var random = Random();
      int randomIndex = random.nextInt(spots.length - 1);
      return spots[randomIndex];
    }
    return null;
  }

  /// Renvoie les spots de l'interval défini
  /// [startIndex] est l'index de début de l'interval
  /// [endIndex] est l'index de fin de l'interval
  List<Spot> getSomeSpots({int startIndex = 0, int endIndex = 15}) {
    if (spots != null &&
        spots.isNotEmpty &&
        startIndex < spots.length &&
        startIndex < endIndex) {
      if (endIndex > spots.length) {
        endIndex = spots.length;
      }
      return spots.getRange(startIndex, endIndex).toList();
    }
    return null;
  }

  /// Renvoie les spots dont le titre contient la chaine de caractère passée
  /// en paramètre
  List<Spot> getSpotsByName(String name) {
    List<Spot> matchingSpots = List();
    if (spots != null && spots.isNotEmpty) {
      for (Spot spot in spots) {
        if (spot.title.toLowerCase().contains(name.toLowerCase())) {
          matchingSpots.add(spot);
        }
      }
    }
    return matchingSpots;
  }

  Future<Spot> getSpot(int idSpot) async {
    Spot spot;
    try {
      var response = await ApiManager().getSpot(idSpot);
      if (response != null && response.data != null) {
        spot = Spot.fromJson(response.data);
      }
    } catch (e, s) {
      print(s);
    }
    return spot;
  }

  Future<SpotComment> sendComment(int idSpot, String comment) async {
    try {
      SpotComment spotComment = SpotComment()
        ..comment = comment
        ..createdAt = DateTime.now().millisecondsSinceEpoch;
      var response = await ApiManager().postComment(idSpot, spotComment);
      if (response != null && response.data != null) {
        // Comment successfully sent
        return spotComment;
      } else {
        return null;
      }
    } catch (e, s) {
      print(s);
      return null;
    }
  }
}
