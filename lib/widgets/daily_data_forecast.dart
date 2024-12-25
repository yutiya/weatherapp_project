import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../model/weather_more_data_day.dart';
import '../utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherMoreDataDay weatherMoreDataDay;

  const DailyDataForecast({super.key, required this.weatherMoreDataDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              'Next Days',
              style: TextStyle(
                fontSize: 17,
                color: CustomColors.textColorBlack,
              ),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: weatherMoreDataDay.moreDayWeathers.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        getTime(weatherMoreDataDay.moreDayWeathers[index].day),
                        style: const TextStyle(
                          fontSize: 13,
                          color: CustomColors.textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                          "assets/weather/${weatherMoreDataDay.moreDayWeathers[index].weatherIcon}.png"),
                    ),
                    Text(
                      '${weatherMoreDataDay.moreDayWeathers[index].tempMax}°C/${weatherMoreDataDay.moreDayWeathers[index].tempMin}°C',
                      style: const TextStyle(
                        fontSize: 13,
                        color: CustomColors.textColorBlack,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              ),
            ],
          );
        },
      ),
    );
  }

  String getTime(int day) {
    return DateFormat("MM/dd HH:mm EEE")
        .format(DateTime.fromMillisecondsSinceEpoch(day * 1000));
  }
}
