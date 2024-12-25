import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/global_controller.dart';
import '../model/weather_current_more_data_day.dart';
import '../utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherCurrentMoreDataDay weatherCurrentMoreDataDay;

  HourlyDataWidget({super.key, required this.weatherCurrentMoreDataDay});

  // card index
  RxInt cardIndex = Get.put(GlobalController(), permanent: true).getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherCurrentMoreDataDay.currentDayWeathers.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.dividerLine.withAlpha(150),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0.5, 0),
                      ),
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor
                          ])
                        : null,
                  ),
                  child: HourlyDetail(
                    temp: weatherCurrentMoreDataDay
                        .currentDayWeathers[index].temp,
                    day:
                        weatherCurrentMoreDataDay.currentDayWeathers[index].day,
                    weatherIcon: weatherCurrentMoreDataDay
                        .currentDayWeathers[index].weatherIcon,
                    cardIndex: cardIndex.value,
                    index: index,
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class HourlyDetail extends StatelessWidget {
  final int temp;
  final int day;
  final String weatherIcon;
  final int cardIndex;
  final int index;

  const HourlyDetail({
    super.key,
    required this.temp,
    required this.day,
    required this.weatherIcon,
    required this.cardIndex,
    required this.index,
  });

  String getTime() {
    return DateFormat("MM/dd HH:mm")
        .format(DateTime.fromMillisecondsSinceEpoch(day * 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(),
            style: TextStyle(
              fontSize: 14,
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°C",
            style: TextStyle(
              fontSize: 16,
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
      ],
    );
  }
}

// Image.network(
//             "http://openweathermap.org/img/wn/$weatherIcon.png",
//             width: 40,
//             height: 40,
//           )
