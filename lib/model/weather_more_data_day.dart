import 'more_day_weather/more_day_weather_result.dart';
import 'more_day_weather/weather_list.dart';

class WeatherMoreDataDay {
  final List<MoreDayWeather> moreDayWeathers;

  WeatherMoreDataDay(
    this.moreDayWeathers,
  );

  factory WeatherMoreDataDay.fromJson(MoreDayWeatherResult moreDayWeather) =>
      WeatherMoreDataDay(
        moreDayWeather.list
                ?.where((e) =>
                    DateTime.fromMillisecondsSinceEpoch(e.dt! * 1000).day !=
                    DateTime.now().day)
                .map((e) => MoreDayWeather.fromJson(e))
                .toList() ??
            [],
      );
}

class MoreDayWeather {
  final int temp;
  final int day;
  final String weatherIcon;
  final int tempMax;
  final int tempMin;

  MoreDayWeather({
    required this.temp,
    required this.day,
    required this.weatherIcon,
    required this.tempMax,
    required this.tempMin,
  });

  factory MoreDayWeather.fromJson(WeatherList weatherList) => MoreDayWeather(
        temp: weatherList.main?.temp?.round() ?? 0,
        day: weatherList.dt ?? 0,
        weatherIcon: weatherList.weather?[0].icon ?? "",
        tempMax: weatherList.main?.tempMax?.round() ?? 0,
        tempMin: weatherList.main?.tempMin?.round() ?? 0,
      );
}
