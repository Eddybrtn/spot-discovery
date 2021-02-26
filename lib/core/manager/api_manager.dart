import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:spot_discovery/core/model/spot_comment.dart';

@singleton
class ApiManager {
  Dio dio;

  ApiManager() {
    print("Creating dio client");
    dio = Dio();
    dio.options.baseUrl =
        "https://spot-discovery-5b840-default-rtdb.firebaseio.com";
  }

  Future<Response<Map<String, dynamic>>> getAllSpots() async =>
      await dio.get<Map<String, dynamic>>("/spots.json");

  Future<Response<Map<String, dynamic>>> getSpot(int idSpot) async =>
      await dio.get<Map<String, dynamic>>("/spot-details/$idSpot.json");

  Future<Response<Map<String, dynamic>>> postComment(int spotId, SpotComment comment) async =>
      await dio.post("/spot-details/$spotId/comments.json",
          data: comment.toJson());
}
