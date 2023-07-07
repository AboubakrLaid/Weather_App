// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather/screens/location/components/getting_loc_dialog.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/services/location_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';

class AutoLocation extends StatefulWidget {
  const AutoLocation({super.key});

  @override
  State<AutoLocation> createState() => _AutoLocationState();
}

class _AutoLocationState extends State<AutoLocation>
    with SingleTickerProviderStateMixin {
  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherData>(
      builder: (context, value, child) {
        return ElevatedButton(
          onPressed: () async {
            if (ConnectivityService.isDeviceConnected) {
              if (await LocationService.checkLocationServices(context)) {
                if (await LocationService.askForLocationPermission(context)) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LocationDialog(),
                  );
                  bool isValidLocation =
                      await LocationService.getCurrentLocation(context);

                  context.pop();
                  if (!isValidLocation &&
                      ConnectivityService.isDeviceConnected) {
                    LocationService.showSnackBar(
                      context,
                      "something went wrong, please enter your state manually",
                    );
                  }
                }
              }
            }
          },
          child: FittedBox(
            child: Text(
              context.localization.translate("get my current position"),
              style: context.theme.textTheme.labelSmall,
            ),
          ),
        );
      },
    );
  }
}
