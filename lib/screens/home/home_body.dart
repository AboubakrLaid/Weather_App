
import 'package:flutter/material.dart';
import 'package:weather/screens/home/components/animated_weather_icon.dart';
import 'package:weather/screens/home/components/week_weather.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

import 'components/extra_info.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<WeatherData>(context, listen: false);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            // height: kHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(66, 152, 181, 0.1),
                  Color.fromRGBO(66, 152, 181, 0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Consumer<Refresh>(
                builder: (context, value, child) => 
                 Consumer<WeatherData>(
                  builder: (context, state, child) => 
                   Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LineIcons.mapMarker,
                            color: context.theme.primaryColor,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            state.currentLocation,
                            style: context.theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20.0.h),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: state.currentWeatherData!.main.temp
                                                .round()
                                                .toString() +
                                            String.fromCharCode(176),
                                        style: context.theme.textTheme.displayLarge
                                            ?.copyWith(fontSize: 90),
                                      ),
                                      TextSpan(
                                        text: "c",
                                        style: context.theme.textTheme.displayLarge
                                            ?.copyWith(
                                          fontSize: 80,
                                          color: context.theme.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedWeatherIcon(
                                size: 100,
                                id: state.currentWeatherData!.weather![0].id,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            state.currentWeatherData!.weather![0].description,
                            style: context.theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 15),
                          RichText(
                            textDirection: appLanguage.isArabic ? TextDirection.rtl: TextDirection.ltr,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${context.localization.translate("feels like")} ",
                                  style: context.theme.textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: state.currentWeatherData!.main.feelsLike
                                          .round()
                                          .toString() +
                                      String.fromCharCode(176),
                                  style: context.theme.textTheme.displayMedium,
                                ),
                                TextSpan(
                                  text: "c",
                                  style: context.theme.textTheme.displayMedium
                                      ?.copyWith(
                                    color: context.theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                
                      // Divider(
                      //   height: 4,
                      //   thickness: 1,
                      //   endIndent: kWidth * 0.3,
                      //   indent: kWidth * 0.3,
                      //   color: context.theme.primaryColor,
                      // ),
                
                      SizedBox(height: 60.h),
                      //
                      //
                      //
                      //
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(LineIcons.info),
                          FittedBox(
                            child: Text(
                              context.localization.translate("Extra info for the day"),
                              style: context.theme.textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                
                      const SizedBox(height: 15),
                
                      const ExtraInfo(),
                
                      SizedBox(height: 60.h),
                
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(LineIcons.calendarWithWeekFocus),
                          FittedBox(
                            child: Text(
                              context.localization.translate("Upcoming weather details"),
                              style: context.theme.textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                
                      const SizedBox(height: 15),
                      for (var days in state.weekDaysWeather.sublist(1))
                        if (days.isNotEmpty) WeekWeather(days),
                
                    
                      
                        
                      
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
