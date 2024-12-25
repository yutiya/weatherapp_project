import '../api/api_key.dart';

String apiURL(var lat, var lon) {
  return "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
}

String apiMoreDayURL(var lat, var lon) {
  return "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
}
