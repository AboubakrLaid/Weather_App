import 'package:flutter/material.dart';
import 'package:weather/model/Suggestion/suggestion.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';

import '../../util/blue_border.dart';
import '../../view_models/weather_data.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: BlueBorder(
            Icon(
              appLanguage.isArabic ? LineIcons.arrowRight : LineIcons.arrowLeft,
              color: context.theme.primaryColor,
            ),
          ),
        ),
        title: Text(
          context.localization.translate("Settings"),
          style: context.theme.textTheme.displayMedium,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile.adaptive(
            // activeColor: context.theme.primaryColor,

            activeTrackColor: context.theme.primaryColor.withAlpha(100),
            inactiveTrackColor: context.theme.primaryColor.withAlpha(100),
            contentPadding: EdgeInsets.zero,
            thumbColor: MaterialStateProperty.all(context.theme.primaryColor),
            thumbIcon: MaterialStateProperty.all(
                Icon(appTheme.isDark ? LineIcons.moon : LineIcons.sun)),
            title: Text(
              context.localization.translate("Toggle Theme Mode"),
              style: context.theme.textTheme.labelSmall,
            ),
            value: appTheme.isDark,
            onChanged: (x) => appTheme.toggleTheme(context),
          ),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () async {
                final state = Provider.of<WeatherData>(context, listen: false);
                final ref = Provider.of<Refresh>(context, listen: false);

                appLanguage.switchLocale();

                WeatherServices x = WeatherServices();
                List<Suggestion> list = (await x.getSearchData(
                  state.favoriteLocation,
                  appLanguage.isArabic ? "en" : "ar",
                ))!;

                state.favoriteLocation =
                //  appLanguage.isArabic
                    // ? list[0].localizedName ?? list[0].name
                     list[0].name;

                state.currentLocation = state.favoriteLocation;

                state.fetchCurrentWeatherData();

                await localDB.setFavoriteLocation(state.currentLocation);

                List<String> otherLocations =
                    await localDB.getLocations() ?? [];
                List<String> temp = [];

                // for (var i = 0; i < otherLocations.length; i++) {

                //   temp.add(await getName(otherLocations[i]));
                // }

                await localDB.setLocations(temp);

                ref.refresh();
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
          ),
        ],
      ),
    );
  }
}

Future<String> getName(String city) async {
  WeatherServices x = WeatherServices();

  Suggestion t =
      (await x.getSearchData(city, appLanguage.currentLocale.languageCode,))![0];

  return t.name;
}
