import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';

import '../controller/global_controller.dart';
import '../utils/custom_colors.dart';
import '../widgets/comfort_level.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_data_forecast.dart';
import '../widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call geolocation service to get user's current location
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => (globalController.checkLoading().isTrue
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/clouds.png'),
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Loading..."),
                  SizedBox(height: 16),
                  Text('如未能加载，请开启定位服务后重试...'),
                ],
              ),
            )
          : Center(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(height: 20),
                  const HeaderWidget(),
                  // for our current temp ('current')
                  CurrentWeatherWidget(
                    weatherDataCurrent:
                        globalController.getWeatherData().getCurrentWeather(),
                  ),
                  const SizedBox(height: 20),
                  // for our hourly data ('hourly')
                  HourlyDataWidget(
                    weatherCurrentMoreDataDay: globalController
                        .getWeatherMoreData()
                        .getCurrentMoreDayWeather(),
                  ),
                  const SizedBox(height: 20),
                  // for our daily data ('daily')
                  DailyDataForecast(
                    weatherMoreDataDay: globalController
                        .getWeatherMoreData()
                        .getMoreDayWeather(),
                  ),
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ),
                  const SizedBox(height: 10),
                  ComfortLevel(
                    weatherDataCurrent:
                        globalController.getWeatherData().getCurrentWeather(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ))),
    ));
  }
}
