import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';

class ExtraInfo extends StatefulWidget {
  const ExtraInfo({super.key});

  @override
  State<ExtraInfo> createState() => _ExtraInfoState();
}

class _ExtraInfoState extends State<ExtraInfo> {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  
  @override
  Widget build(BuildContext context) {
    

    return Scrollbar(
      controller: _controller,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      thumbVisibility: true,
      interactive: true,
      thickness: 2.0,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.w),
          child: Consumer<WeatherData>(
            builder: (context, state, child) => 
             Row(
              children: [
                const SizedBox(width: 20),
                if (state.currentWeatherData?.wind != null)
                  Column(
                    children: [
                      Text(
                        context.localization.translate("Wind"),
                        style: context.theme.textTheme.bodySmall,
                      ),
                      Text(
                        "${(state.currentWeatherData!.wind!.speed! * 3.6).toStringAsFixed(1)} ${ context.localization.translate('km/h')}",
                        style: context.theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      context.localization.translate("Humidity"),
                      style: context.theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${(state.currentWeatherData!.main.humidity)} %",
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      context.localization.translate("Pressure"),
                      style: context.theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${(state.currentWeatherData!.main.pressure)} ${ context.localization.translate('hPa')}",
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                if (state.currentWeatherData?.clouds != null)
                  Column(
                    children: [
                      Text(
                        context.localization.translate("Clouds"),
                        style: context.theme.textTheme.bodySmall,
                      ),
                      Text(
                        "${(state.currentWeatherData!.clouds!.all)} %",
                        style: context.theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      context.localization.translate("Visibility"),
                      style: context.theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${(state.currentWeatherData!.visibilty / 1000)} ${ context.localization.translate('km')}",
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                if (state.currentWeatherData?.rain != null)
                  Column(
                    children: [
                      Text(
                        context.localization.translate("Rain"),
                        style: context.theme.textTheme.bodySmall,
                      ),
                      Text(
                        "${(state.currentWeatherData!.rain?.h1)} ${ context.localization.translate('mm')}",
                        style: context.theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
