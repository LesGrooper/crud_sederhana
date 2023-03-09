import 'package:crud_sederhana/models/comic_model.dart';
import 'package:crud_sederhana/models/request_model.dart';

import 'package:dio/dio.dart';

class NetworkManager {
  late Dio _dio;
  String baseUrl = 'http://192.168.1.2:1337/api';

  NetworkManager() {
    _dio = Dio();
  }
  Future<ComicModel> getAll() async {
    final response = await _dio.get(
      "$baseUrl/comics",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    return ComicModel.fromJson(response.data);
  }

  Future<void> addData(RequestComic request) async {
    var response = await _dio.post(
      "$baseUrl/comics",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {"data": request.toJson()},
    );
  }
}
