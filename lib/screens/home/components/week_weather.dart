import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_list.dart';
import 'package:weather/screens/home/components/animated_weather_icon.dart';
import 'package:weather/util/export.dart';

class WeekWeather extends StatefulWidget {
  const WeekWeather(this.days, {super.key});

  final List<DailyForeCastList> days;

  @override
  State<WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<WeekWeather> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<WeatherData>(context, listen: false);
    DateTime date = DateTime.parse(widget.days[0].dtTxt);
    // int index = date.weekday - 1;

    return ExpansionTile(
      trailing: Icon(
          isExpanded ? LineIcons.chevronCircleUp : LineIcons.chevronCircleDown),
      onExpansionChanged: (value) => setState(() => isExpanded = value),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      //childrenPadding: EdgeInsets.only(left: 13.w),
// expandedAlignment: ,
      title: Text(
        Jiffy.parseFromDateTime(date).format(pattern: "EEEE, MMMM dd"),
        style: context.theme.textTheme.displaySmall,
      ),
      children: [
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.days.length,
            itemBuilder: (context, index) {
              //
              //
              DateTime foreCastDate = DateTime.parse(widget.days[index].dtTxt);

              return Container(
                alignment: Alignment.center,
                margin:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: context.theme.primaryColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FittedBox(
                      child: Text(
                        Jiffy.parseFromDateTime(foreCastDate)
                            .format(pattern: "HH:mm"),
                        style: context.theme.textTheme.bodySmall,
                      ),
                    ),
                    AnimatedWeatherIcon(
                      size: 35,
                      id: widget.days[index].weather[0].id,
                      pod: widget.days[index].sys.pod,
                    ),
                    FittedBox(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: widget.days[index].main.feelsLike
                                        .round()
                                        .toString() +
                                    String.fromCharCode(176),
                                style: context.theme.textTheme.bodyLarge),
                            TextSpan(
                              text: "c",
                              style:
                                  context.theme.textTheme.bodySmall?.copyWith(
                                color: context.theme.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}


// Row(
//       children: [
//         Text(
//           Jiffy.parseFromDateTime(date).format(pattern: "EEEE, d"),
//           style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 20),
//         ),
//         const SizedBox(width: 10),
//         Text("${day.main.tempMax}"),
//         const SizedBox(width: 10),

//         Text("${day.main.tempMin}"),
//       ],
//     )