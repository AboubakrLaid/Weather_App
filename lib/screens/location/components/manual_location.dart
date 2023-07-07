// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather/screens/location/components/getting_loc_dialog.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/services/location_service.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';

class ManualLocation extends StatelessWidget {
  const ManualLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<WeatherData>(context, listen: false);
    GlobalKey<FormState> key = GlobalKey<FormState>();
    //
    //
    return Form(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: kWidth * 0.7,
        child: Consumer<WeatherData>(
          builder: (context, value, child) => TextFormField(
            controller: state.locationController,
            cursorColor: context.theme.primaryColor,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            onFieldSubmitted: (value) async {
              final x = WeatherServices();
              showDialog(
                context: context,
                builder: (context) => const LocationDialog(),
              );
              final currentWeatherData = await x.getCurrentWeatherData(
                value.trim(),
                appLanguage.currentLocale.languageCode,
              );
              final foreCastWeatherData = await x.getDailyForeCastWeatherData(
                value,
                appLanguage.currentLocale.languageCode,
              );
              if (currentWeatherData != null && foreCastWeatherData != null) {
                final country = currentWeatherData.sys.country;

                Provider.of<WeatherData>(context, listen: false).setData(
                  currentWeatherData.name,
                  country,
                  currentWeatherData: currentWeatherData,
                  foreDailyCastWeatherData: foreCastWeatherData,
                );
              } else {
                Provider.of<WeatherData>(context, listen: false)
                  ..setData("", "")
                  ..hideContinue();
                if (ConnectivityService.isDeviceConnected) {
                  LocationService.showSnackBar(
                    context,
                    context.localization.translate(
                        "Please double-check the spelling of your input"),
                  );
                }
              }
              context.pop();
            },
            decoration: InputDecoration(
              hintText: context.localization
                  .translate("enter your state (ex: Mostaganem)"),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: context.theme.primaryColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: context.theme.primaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: context.theme.primaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}
