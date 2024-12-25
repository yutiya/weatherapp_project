import 'weather_data_current.dart';

class WeatherData {
  final WeatherDataCurrent? currentWeather;

  // 可空参数可以这样写
  // WeatherData({
  //   this.currentWeather,
  // });

  // 可空参数也可以这样写
  WeatherData([
    this.currentWeather,
  ]);

  // function to fetch these values
  WeatherDataCurrent getCurrentWeather() => currentWeather!;
}
