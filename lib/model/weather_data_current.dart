import 'current/weather_result.dart';
import 'common/weather.dart';

class WeatherDataCurrent {
  final CurrentWeather currentWeather;

  // 这样写，调用的时候必须写上参数名
  // WeatherDataCurrent({
  //   required this.currentWeather,
  // });

  // 这样写，参数就是对应顺序传入了
  WeatherDataCurrent(
    this.currentWeather,
  );

  factory WeatherDataCurrent.fromJson(WeatherResult weatherResult) =>
      WeatherDataCurrent(
        CurrentWeather.fromJson(weatherResult),
      );
}

class CurrentWeather {
  int? temp;
  int? humidity;
  String? clouds;
  double? windSpeed;
  List<Weather>? weather;

  double? visibility;
  double? feelsLike;

  CurrentWeather({
    this.temp,
    this.humidity,
    this.clouds,
    this.windSpeed,
    this.weather,
    this.visibility,
    this.feelsLike,
  });

  factory CurrentWeather.fromJson(WeatherResult weatherResult) =>
      CurrentWeather(
        temp: weatherResult.main!.temp!.round(),
        humidity: weatherResult.main!.humidity,
        clouds: weatherResult.weather![0].icon,
        windSpeed: weatherResult.wind!.speed,
        weather: weatherResult.weather,
        visibility: weatherResult.visibility!.toDouble(),
        feelsLike: weatherResult.main!.feelsLike,
      );
}
