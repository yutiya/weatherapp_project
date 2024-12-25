// 5天/3小时预报数据

import 'weather_current_more_data_day.dart';
import 'weather_more_data_day.dart';

class WeatherMoreData {
  final WeatherCurrentMoreDataDay? currentDayWeather;
  final WeatherMoreDataDay? moreDayWeather;

  WeatherMoreData([
    this.currentDayWeather,
    this.moreDayWeather,
  ]);

  // function to fetch these values
  WeatherCurrentMoreDataDay getCurrentMoreDayWeather() => currentDayWeather!;
  WeatherMoreDataDay getMoreDayWeather() => moreDayWeather!;
}
