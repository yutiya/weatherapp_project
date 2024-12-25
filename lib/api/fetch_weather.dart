import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/more_day_weather/more_day_weather_result.dart';
import '../model/current/weather_result.dart';
import '../model/weather_current_more_data_day.dart';
import '../model/weather_data.dart';
import '../model/weather_data_current.dart';
import '../model/weather_more_data.dart';
import '../model/weather_more_data_day.dart';
import '../utils/api_url.dart';

class FetchWeatherAPI {
  // procecssing the data from response -> to json
  Future<WeatherData?> processData(String lat, String lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      var weatherResult = WeatherResult.fromJson(jsonString);
      var weatherData = WeatherData(WeatherDataCurrent.fromJson(weatherResult));
      return weatherData;
    } else {
      return null;
    }
  }

  Future<WeatherMoreData?> processMoreDayData(String lat, String lon) async {
    var response = await http.get(Uri.parse(apiMoreDayURL(lat, lon)));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      var moreDayWeatherResult = MoreDayWeatherResult.fromJson(jsonString);
      var weatherMoreData = WeatherMoreData(
          WeatherCurrentMoreDataDay.fromJson(moreDayWeatherResult),
          WeatherMoreDataDay.fromJson(moreDayWeatherResult));
      return weatherMoreData;
    } else {
      return null;
    }
  }
}
