// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather/model/Current_Weather/current_weather.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_forecast_weather.dart';
import 'package:weather/model/Suggestion/suggestion.dart';
import 'package:weather/screens/home/components/animated_weather_icon.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

class SearchLocation extends SearchDelegate {
  bool isLoading = false;
  String prevQuery = "";
  List<Suggestion> suggestions = [];

  Future<List<Suggestion>?> search() async {
    WeatherServices weatherService = WeatherServices();
    return await weatherService.getSearchData(
      query,
      appLanguage.currentLocale.languageCode,
    );
  }

  Future<void> markAsFavorite(BuildContext context, String city) async {
    final ref = Provider.of<Refresh>(context, listen: false);
    final x = Provider.of<WeatherData>(context, listen: false);

    isLoading = true;
    ref.refresh();
    await localDB.setFavoriteLocation(city);

    List<String> otherLoc = await localDB.getLocations() ?? [];

    if (otherLoc.contains(city)) {
      otherLoc.remove(city);
      await localDB.setLocations(otherLoc);
      x.otherLocations = otherLoc;
      ref.refresh();
    }

    x.currentLocation = city;
    x.favoriteLocation = city;
    await x.fetchCurrentWeatherData();
    await x.fetchDailyForeCastWeatherData();

    isLoading = false;
    ref.refresh();
    close(context, "");
  }

  Future<void> addLocation(BuildContext context, String city) async {
    final ref = Provider.of<Refresh>(context, listen: false);

    List<String> otherLoc = await localDB.getLocations() ?? [];

    if (otherLoc.length == 10) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.localization
              .translate("Can't add more than 10 locations,try to delete"))));
    } else if (otherLoc.contains(city)) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(context.localization.translate("Location already added"))));
    } else {
      context.pop();

      otherLoc.insert(0, city);
      Provider.of<WeatherData>(context, listen: false).otherLocations =
          otherLoc;
      await localDB.setLocations(otherLoc);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              context.localization.translate("Location added successfully"))));
      ref.refresh();
    }
  }

  // app bar decoration
  @override
  ThemeData appBarTheme(BuildContext context) {
    return context.theme.copyWith(
      useMaterial3: true,
      appBarTheme: context.theme.appBarTheme,
      indicatorColor: context.theme.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: context.theme.appBarTheme.backgroundColor,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.theme.primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.theme.primaryColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.theme.primaryColor),
        ),
      ),
    );
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 20,
        color: appTheme.isDark
            ? const Color.fromRGBO(170, 170, 170, 1)
            : const Color.fromRGBO(30, 30, 31, 1),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: AnimatedScale(
          scale: query.isEmpty ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: IconButton(
            onPressed: () => query = "",
            icon: Icon(
              LineIcons.times,
              color: context.theme.primaryColor,
              size: 30,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: Icon(
        appLanguage.isArabic ? LineIcons.arrowRight : LineIcons.arrowLeft,
        color: context.theme.primaryColor,
        size: 30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listOfSuggestion(suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      initialData: const <Suggestion>[],
      future: query.isNotEmpty ? search() : null,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
                child: Text(
                    context.localization.translate("Enter a location name")));

          case ConnectionState.waiting:
            return Center(
              child:
                  CircularProgressIndicator(color: context.theme.primaryColor),
            );
          case ConnectionState.active:
            return Text(context.localization.translate("active"));
          default: // done state
            suggestions = snapshot.data ?? [];
            return suggestions.isNotEmpty
                ? listOfSuggestion(suggestions)
                : Center(
                    child: ConnectivityService.isDeviceConnected
                        ? Text(
                            context.localization.translate("No result found"))
                        : Text(context.localization
                            .translate("No internet connection")),
                  );

          // return ListView.builder(
          //   itemCount: suggestions.length,
          //   itemBuilder: (context, index) => Text(suggestions[index].name),
          // );
        }
      },
    );
  }

  ListView listOfSuggestion(List<Suggestion> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final city = 
        // appLanguage.isArabic
            // ? (suggestions[index].localizedName ?? suggestions[index].name)
             suggestions[index].name;
        // String country = appLanguage.isArabic
        //     ? suggestions[index].country.localizedName
        //     : suggestions[index].country.name;

        // country = country.toLowerCase() == "isreal"
        //     ? "Palestine"
        //     : country.toLowerCase() == "إسرائيل"
        //         ? "فلسطين"
        //         : country;
        return ListTile(
          onTap: () async {
            // showDialog(context: context, builder: (context) => const LocationDialog(),);
            final x = WeatherServices();
            CurrentWeather? suggestionWeather = await x.getCurrentWeatherData(
              city,
              appLanguage.currentLocale.languageCode,
            );
            DailyForeCastWeather? suggestionWeatherDaily =
                await x.getDailyForeCastWeatherData(
              city,
              appLanguage.currentLocale.languageCode,
            );
            bool found =
                suggestionWeather != null && suggestionWeatherDaily != null;
            if (found) {
              // context.pop();
              showModalBottomSheet(
                context: context,
                //enable child to take as much space as it need
                isScrollControlled: true,
                showDragHandle: true,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                builder: (context) => suggestionWeatherData(
                  city,
                  context,
                  suggestionWeather,
                  suggestionWeatherDaily,
                ),
              );
              FocusManager.instance.primaryFocus!.unfocus();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(context.localization
                      .translate("Something went wrong, try again later."))));
            }
          },
          // title: Text(
          //   "$city, $country",
          //   style: context.theme.textTheme.labelMedium,
          // ),
        );
      },
    );
  }

  Padding suggestionWeatherData(
    String city,
    BuildContext context,
    CurrentWeather suggestionWeather,
    DailyForeCastWeather suggestionWeatherDaily,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                city,
                style: context.theme.textTheme.labelLarge,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async => await addLocation(context, city),
                    icon: Icon(
                      LineIcons.plus,
                      color: context.theme.primaryColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () async => await markAsFavorite(context, city),
                    icon: Consumer<Refresh>(
                      builder: (context, value, child) => isLoading
                          ? CircularProgressIndicator(
                              color: context.theme.primaryColor,
                            )
                          : Icon(
                              LineIcons.star,
                              color: context.theme.primaryColor,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 26.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: suggestionWeather.main.temp.round().toString() +
                              String.fromCharCode(176),
                          style: context.theme.textTheme.displayLarge
                              ?.copyWith(fontSize: 50),
                        ),
                        TextSpan(
                          text: "c",
                          style: context.theme.textTheme.displayLarge?.copyWith(
                            fontSize: 50,
                            color: context.theme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    suggestionWeather.weather![0].description,
                    style: context.theme.textTheme.bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "${context.localization.translate('humidity')} ${suggestionWeather.main.humidity} %",
                    style: context.theme.textTheme.bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "${context.localization.translate('clouds')} ${suggestionWeather.clouds!.all} %",
                    style: context.theme.textTheme.bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
              AnimatedWeatherIcon(
                id: suggestionWeather.weather![0].id,
                size: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
