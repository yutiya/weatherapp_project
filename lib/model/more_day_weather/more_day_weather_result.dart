import 'city.dart';
import 'weather_list.dart';

class MoreDayWeatherResult {
  String? cod;
  int? message;
  int? cnt;
  List<WeatherList>? list;
  City? city;

  MoreDayWeatherResult(
      {this.cod, this.message, this.cnt, this.list, this.city});

  factory MoreDayWeatherResult.fromJson(Map<String, dynamic> json) {
    return MoreDayWeatherResult(
      cod: json['cod'] as String?,
      message: json['message'] as int?,
      cnt: json['cnt'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => WeatherList.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': list?.map((e) => e.toJson()).toList(),
        'city': city?.toJson(),
      };
}
