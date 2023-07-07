import 'package:flutter/material.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

typedef delete = void Function(List<int> x);

class FooterButton extends StatelessWidget {
  const FooterButton({super.key});
  // final delete  deleteAll;

  @override
  Widget build(BuildContext context) {
    //
    void selectAll(Refresh ref, bool allSelected) {
      for (int i = 0; i < ref.selectedLocationList.length; i++) {
        ref.selectedLocationList[i] = !allSelected;
      }
      ref.refresh();
    }

    //
    Future<void> delete(Refresh ref) async {
      List<String> tempList = [];

      final state = Provider.of<WeatherData>(context, listen: false);
      for (int i = 0; i < ref.selectedLocationList.length; i++) {
        if (!ref.selectedLocationList[i]) {
          // keep unselected locations
          tempList.add(state.otherLocations[i]);
        }
      }
      ref.selectedLocationList =
          List.generate(tempList.length, (index) => false);
      state.otherLocations = tempList;
      await localDB.setLocations(state.otherLocations);
      ref.isEditing = false;
      ref.refresh();
    }

    //
    Future<void> favorite(Refresh ref) async {
      final state = Provider.of<WeatherData>(context, listen: false);

      int index = ref.selectedLocationList.indexWhere((element) => element);
      if (index != -1) {
        String x = state.favoriteLocation;
        state.favoriteLocation = state.otherLocations[index];

        state.currentLocation = state.otherLocations[index];
        // set new fav loc
        await localDB.setFavoriteLocation(state.otherLocations[index]);

        state.otherLocations[index] = x;
        ref.selectedLocationList[index] = false;
        // replace new fav loc with old fav loc in
        await localDB.setLocations(state.otherLocations);

        // set home with new data of favorite loc
        await state.fetchCurrentWeatherData();
        await state.fetchDailyForeCastWeatherData();
        ref.refresh();
      }
    }

    return Consumer<Refresh>(
      builder: (context, ref, child) {
        int selectedItemCount =
            ref.selectedLocationList.where((x) => x).toList().length;

        bool allSelected = ref.selectedLocationList.every((element) => element);

        return ConnectivityService.isDeviceConnected
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.only(top: 8.0),
                color: context.theme.scaffoldBackgroundColor,
                height: ref.isEditing ? 40.h : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => selectAll(ref, allSelected),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(allSelected ? LineIcons.times : LineIcons.check),
                          const SizedBox(width: 8),
                          Text(
                            allSelected ? context.localization.translate("Unselect all") : context.localization.translate("Select all"),
                            style: context.theme.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    if (selectedItemCount == 1)
                      InkWell(
                        onTap: () async => await favorite(ref),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LineIcons.star),
                            const SizedBox(width: 8),
                            Text(
                              context.localization.translate("favorite"),
                              style: context.theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    if (selectedItemCount > 0)
                      InkWell(
                        onTap: () async => await delete(ref),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LineIcons.trash),
                            const SizedBox(width: 8),
                            Text(
                              context.localization.translate("delete"),
                              style: context.theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : const SizedBox(height: 0.0);
      },
    );
  }
}
