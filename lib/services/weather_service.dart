import 'package:weather/api/api_repo.dart';
import 'package:weather/model/Current_Weather/current_weather.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_forecast_weather.dart';
import 'package:weather/model/Suggestion/suggestion.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/globale_variables.dart';

class WeatherServices {
  // https://api.openweathermap.org/data/2.5/weather?q=casablanca&sunrise=utc&sunset=utc&lang=en&units=metric&appid=5162c52f6732ad6a82b2eb3b67c7f406
  final String weatherKey = "5162c52f6732ad6a82b2eb3b67c7f406";

  // final String searchKey = "98619f4b2emsh13af5568ed5a938p11cdd3jsnc4ea58d33554";

  final String baseUrl = "api.openweathermap.org/data/2.5";

  Future<CurrentWeather?> getCurrentWeatherData(String city, String lang) async {
    // lang en or ar
    log.d("-------$lang");
  if (ConnectivityService.isDeviceConnected) {
    ApiRepo api = ApiRepo();
    String url =
        "https://$baseUrl/weather?q=$city&units=metric&appid=$weatherKey&lang=$lang";
    final data = await api.getDataOfWeather(url);
    if (data == null) {
      log.e("current data failed");

      return null;
    } else {
      log.d("current data success");

      return CurrentWeather.fromJson(data);
    }
  }else{
    log.d("no internet");
    return null;
  }
    
  }


  Future<DailyForeCastWeather?> getDailyForeCastWeatherData(String city,String lang) async {
    // lang en or ar
    log.d("-------$lang");

   if (ConnectivityService.isDeviceConnected) {
      ApiRepo api = ApiRepo();
    String url = "https://$baseUrl/forecast?q=$city&units=metric&appid=$weatherKey&lang=$lang";

    final data = await api.getDataOfWeather(url);
    if (data == null) {
      log.e("daily data failed");

      return null;
    } else {
      log.d("daily data success");

      return DailyForeCastWeather.fromJson(data);
    }
   }else{
   log.d("no internet");
    return null;
   }
  }


 
  

  Future<List<Suggestion>?> getSearchData(String q, String lang) async {
 const String apiKey =
          "pk.05b9b739d0facfa050aef49a98211ceb";
    // language ar or en
    if (ConnectivityService.isDeviceConnected) {
      ApiRepo api = ApiRepo();
    final String url =
        "https://api.locationiq.com/v1/autocomplete?key=$apiKey&q=$q&limit=10&dedupe=1&tag=place:city";

    final data = await api.getDataOfSearch(url);
    if (data == null) {
      log.e("search data failed");
      return null;
    } else {
      log.d("search data success");
print(data);
      return data.map<Suggestion>((city) => Suggestion.fromJson(city)).toList();
    }
    } else{
       log.d("no internet connection");
      return null;
    }
  }

}