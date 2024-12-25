import 'more_day_weather/more_day_weather_result.dart';
import 'more_day_weather/weather_list.dart';

class WeatherCurrentMoreDataDay {
  final List<CurrentDayWeather> currentDayWeathers;

  WeatherCurrentMoreDataDay(
    this.currentDayWeathers,
  );

  factory WeatherCurrentMoreDataDay.fromJson(
          MoreDayWeatherResult moreDayWeather) =>
      WeatherCurrentMoreDataDay(
        moreDayWeather.list
                ?.where((e) =>
                    DateTime.fromMillisecondsSinceEpoch(e.dt! * 1000).day ==
                    DateTime.now().day)
                .map((e) => CurrentDayWeather.fromJson(e))
                .toList() ??
            [],
      );
}

class CurrentDayWeather {
  final int temp;
  final int day;
  final String weatherIcon;

  CurrentDayWeather(
      {required this.temp, required this.day, required this.weatherIcon});

  factory CurrentDayWeather.fromJson(WeatherList weatherList) =>
      CurrentDayWeather(
        temp: weatherList.main?.temp?.round() ?? 0,
        day: weatherList.dt ?? 0,
        weatherIcon: weatherList.weather?[0].icon ?? "",
      );
}
