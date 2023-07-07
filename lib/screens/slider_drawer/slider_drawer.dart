// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather/screens/slider_drawer/components/info_bottom_sheet.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

class SliderDrawer extends StatefulWidget {
  const SliderDrawer({super.key, required this.animation});
  final AnimationController animation;

  @override
  State<SliderDrawer> createState() => _SliderDrawerState();
}

class _SliderDrawerState extends State<SliderDrawer> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<WeatherData>(context, listen: false);

    void changeCurrentLocation(String loc) async {
      if (ConnectivityService.isDeviceConnected) {
        final x = Provider.of<WeatherData>(context, listen: false);
        x.currentLocation = loc;
        await x.fetchCurrentWeatherData(otherLocation: loc);
        await x.fetchDailyForeCastWeatherData(otherLocation: loc);
        widget.animation.reverse();
        context.pop();
      } else {
        widget.animation.reverse();
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                context.localization.translate("No internet connection"))));
      }
    }

    var divider = Divider(
                    color: context.theme.primaryColor,
                    indent: 16.0,
                    endIndent: 16.0,
                    height: 50.0,
                  );
    return WillPopScope(
      onWillPop: () {
        widget.animation.reverse();
        return Future.value(true);
      },
      child: Scaffold(
        body: Align(
          alignment: appLanguage.isArabic
              ? const Alignment(-1, 0)
              : const Alignment(1, 0),
          child: SizedBox(
            width: kWidth * 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 56.h),
                  
                  ListTile(
                    onTap: ()=>context.pushNamed("Settings"),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      context.localization.translate("Settings"),
                      style: context.theme.textTheme.labelSmall,
                    ),
                    leading: Icon(
                      LineIcons.cog,
                      color: context.theme.primaryColor,
                    ),
                  ),
                  divider,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      context.localization.translate("Favorite location"),
                      style: context.theme.textTheme.labelSmall,
                    ),
                    leading: Icon(
                      LineIcons.star,
                      color: context.theme.primaryColor,
                    ),
                    trailing: Builder(
                      builder: (context) => IconButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              context.theme.scaffoldBackgroundColor,
                          showDragHandle: true,
                          builder: (context) => const InfoBottomSheet(),
                        ),
                        icon: const Icon(LineIcons.info),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 38.0.w),
                    child: TextButton(
                      onPressed: () =>
                          changeCurrentLocation(state.favoriteLocation),
                      child: Consumer<WeatherData>(
                        builder: (context, value, child) => Text(
                          state.favoriteLocation,
                          style:
                              context.theme.textTheme.headlineMedium!.copyWith(
                            color:
                                state.favoriteLocation == value.currentLocation
                                    ? context.theme.primaryColor
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  divider,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      context.localization.translate("Other locations"),
                      style: context.theme.textTheme.labelSmall,
                    ),
                    leading: Icon(
                      LineIcons.globe,
                      color: context.theme.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: state.otherLocations.isEmpty
                        ? 0
                        : state.otherLocations.length > 4
                            ? kHeight * 0.3
                            : kHeight * 0.2,
                    child: Scrollbar(
                      controller: _controller,
                      thumbVisibility: true,
                      interactive: true,
                      thickness: 2.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 38.0.w),
                        child: Consumer<Refresh>(
                          builder: (context, value, child) => ListView(
                            controller: _controller,
                            children: [
                              for (String loc in state.otherLocations)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0.h),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      alignment: appLanguage.isArabic
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                    ),
                                    onPressed: () => changeCurrentLocation(loc),
                                    child: Text(
                                      loc,
                                      style: context
                                          .theme.textTheme.headlineMedium!
                                          .copyWith(
                                        color: loc == state.currentLocation
                                            ? context.theme.primaryColor
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: context.theme.primaryColor,
                    indent: 16.0,
                    endIndent: 16.0,
                    height: 50.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // await widget.animation.reverse();
                        // context.pop();
                        context.pushNamed("ManageLocations");
                      },
                      child: Text(
                        context.localization.translate("Manage locations"),
                        style: context.theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                  Divider(
                    color: context.theme.primaryColor,
                    indent: 16.0,
                    endIndent: 16.0,
                    height: 50.0,
                  ),
                  const Expanded(child: SizedBox(height: 1)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
