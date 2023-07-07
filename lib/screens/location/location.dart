// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/screens/location/components/auto_location.dart';
import 'package:weather/screens/location/components/manual_location.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/fetch_weather.dart';
import 'package:weather/view_models/weather_data.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    //  checkInternet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: kHeight * 0.1),
                TextButton(
                  onPressed: () {
                    Provider.of<WeatherData>(context, listen: false)
                      ..hideContinue()
                      ..favoriteLocation = "";
                    appLanguage.switchLocale();
                  },
                  style: TextButton.styleFrom(alignment: Alignment.center),
                  child: Text(
                    context.localization.translate(
                      appLanguage.isArabic ? "English" : "Arabic",
                    ),
                    style: context.theme.textTheme.displayMedium!
                        .copyWith(color: context.theme.primaryColor),
                  ),
                ),
                SizedBox(height: kHeight * 0.1),
                SizedBox(
                  width: kWidth * 0.98,
                  height: kHeight * 0.45,
                  child: SvgPicture.asset(
                    "images/location.svg",
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Consumer<WeatherData>(
                  builder: (context, value, child) => Text(
                    value.favoriteLocation,
                    style: context.theme.textTheme.displayMedium,
                  ),
                ),
                SizedBox(height: kHeight * 0.02),
                ExpansionPanelList.radio(
                  elevation: 2,
                  animationDuration: const Duration(milliseconds: 200),
                  dividerColor: context.theme.primaryColor,
                  children: [
                    ExpansionPanelRadio(
                      value: 1,
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return Container(
                          alignment: appLanguage.isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          padding: appLanguage.isArabic
                              ? EdgeInsets.only(right: 20.0.w)
                              : EdgeInsets.only(left: 20.0.w),
                          child: const DisplayText("Manually"),
                        );
                      },
                      body: const ExpansionBody(body: ManualLocation()),
                    ),
                    ExpansionPanelRadio(
                        value: 2,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          return Container(
                            alignment: appLanguage.isArabic
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: appLanguage.isArabic
                                ? EdgeInsets.only(right: 20.0.w)
                                : EdgeInsets.only(left: 20.0.w),
                            child: const DisplayText("Automatically"),
                          );
                        },
                        body: const ExpansionBody(body: AutoLocation())),
                  ],
                ),
                SizedBox(height: kHeight * 0.1),
                Consumer<WeatherData>(
                  builder: (context, value, child) => AnimatedScale(
                    scale: value.showContinue ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        if (value.showContinue) {
                          await localDB.markOnBordingAsSeen();
                          await localDB
                              .setFavoriteLocation(value.favoriteLocation);
                          Provider.of<FetchWeather>(context, listen: false)
                              .fetchAllWeatherInfo(context);
                          context.pushReplacementNamed("Home");
                        }
                      },
                      child: Text(
                        value.showContinue
                            ? context.localization.translate("Continue")
                            : "",
                        style: context.theme.textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: kHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        initialData: ConnectivityService.isDeviceConnected,
        stream: ConnectivityService.myStreamController.stream,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 370),
                  color: context.theme.secondaryHeaderColor,
                  height: !snapshot.data! ? 25.h : 0,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        context.localization
                            .translate("No internet connection"),
                        style: context.theme.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                )
              : Container(height: 0);
        },
      ),
    );
  }
}

class DisplayText extends StatelessWidget {
  const DisplayText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localization.translate(text),
      style: context.theme.textTheme.displaySmall,
    );
  }
}

class ExpansionBody extends StatelessWidget {
  const ExpansionBody({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: body,
    );
  }
}
