import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../api/fetch_weather.dart';
import '../model/weather_data.dart';
import '../model/weather_more_data.dart';

class GlobalController extends GetxController {
  // create various values
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  // instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() => weatherData.value;

  final weatherMoreData = WeatherMoreData().obs;
  WeatherMoreData getWeatherMoreData() => weatherMoreData.value;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;

    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // return if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location service is not enabled.");
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    // request permission if it is not granted
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever.");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission if it is denied
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied.");
      }
    }

    // getting the current location
    return await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.high))
        .then((value) {
      // update out latitude and longitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      // calling out weather API here
      // return FetchWeatherAPI()
      //     .processData(value.latitude.toString(), value.longitude.toString())
      //     .then((value) {
      //   if (value != null) {
      //     weatherData.value = value;
      //     _isLoading.value = false;
      //   }
      // });

      // calling out weather API here
      List<Future> dataListFuture = [
        FetchWeatherAPI()
            .processData(value.latitude.toString(), value.longitude.toString())
            .then((value) {
          if (value != null) {
            weatherData.value = value;
          }
        }),
        FetchWeatherAPI()
            .processMoreDayData(
                value.latitude.toString(), value.longitude.toString())
            .then((value) {
          if (value != null) {
            weatherMoreData.value = value;
          }
        }),
      ];

      return Future.wait(dataListFuture).then((value) {
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
