// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/fetch_weather.dart';

class RetrivingData extends StatefulWidget {
  const RetrivingData({super.key});

  @override
  State<RetrivingData> createState() => _RetrivingDataState();
}

class _RetrivingDataState extends State<RetrivingData> {
  @override
  void initState() {
    super.initState();
     Provider.of<FetchWeather>(context, listen: false)
          .fetchAllWeatherInfo(context);
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Consumer<FetchWeather>(
            builder: (context, state, child) {
   
              return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.localization.translate(state.info),
                  style: context.theme.textTheme.labelMedium,
                ),
                SizedBox(width: 10.w),
                state.noError
                    ? CircularProgressIndicator(
                        strokeWidth: 6.0,
                        color: context.theme.primaryColor,
                      )
                    : TextButton(
                        onPressed: () {
                          state.fetchAllWeatherInfo(context);
                        },
                        child: Text(
                          context.localization.translate("Try again"),
                          style: context.theme.textTheme.labelMedium
                              ?.copyWith(color: context.theme.primaryColor),
                        ),
                      ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
