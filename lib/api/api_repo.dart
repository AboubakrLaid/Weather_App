import 'package:dio/dio.dart';
import 'package:weather/util/globale_variables.dart';

class ApiRepo {
  ApiRepo._();

  static final _instance = ApiRepo._();

  factory ApiRepo() => _instance;

  static final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getDataOfWeather(String url) async {
    try {
     
      Response<Map<String, dynamic>> response = await _dio.get(url);
      log.e(response.statusMessage);
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        
        return response.data;
      }
      return null;
    } catch (e) {
      log.e("getting data api error $e");
      return null;
    }
  }

  Future<List<dynamic>?> getDataOfSearch(String url) async {
    try {
      const String apiKey =
          "pk.05b9b739d0facfa050aef49a98211ceb";
      const String host = "spott.p.rapidapi.com";
     
      Response<List<dynamic>> response = await _dio.get<List<dynamic>>(
        url,
        // options: Options(
        //   headers: {
        //     "X-Rapidapi-Key": apiKey,
        //     "X-Rapidapi-Host": host,
        //   },
        // ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        
        return response.data ;
      }
      return null;
    } catch (e) {
      log.e("getting search data api error = $e");
      return null;
    }
  }
}
