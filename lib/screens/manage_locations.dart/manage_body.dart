import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

class ManageLocationBody extends StatefulWidget {
  const ManageLocationBody({super.key});

  @override
  State<ManageLocationBody> createState() => _ManageLocationBodyState();
}

class _ManageLocationBodyState extends State<ManageLocationBody> {
  // List<String> tempList = [];

  @override
  void initState() {
    super.initState();
    final state = Provider.of<WeatherData>(context, listen: false);
    final ref = Provider.of<Refresh>(context, listen: false);
    ref.isEditing = false;

    ref.selectedLocationList =
        List.generate(state.otherLocations.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherData>(
      builder: (context, value, child) => Center(
        child: Consumer<Refresh>(
          builder: (context, ref, child) {
            return GestureDetector(
              onTap: () {
                ref.isEditing = false;
                ref.refresh();
              },
              child: ListView.builder(
                //
                //

                itemCount: value.otherLocations.length + 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      if (index != 0) {
                        ref.isEditing = true;
                        ref.selectedLocationList[index -1] = true;
                        ref.refresh();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0.w,
                        vertical: 16.0.h,
                      ),
                      padding: EdgeInsets.only(
                        top: 8.0.h,
                        bottom: 8.0.h,
                        left: appLanguage.isArabic? 0: 16.0,
                        right: appLanguage.isArabic? 16.0: 0,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 16.0),
                        title: index != 0
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                
                                    alignment:appLanguage.isArabic? Alignment.centerRight: Alignment.centerLeft,
                                    children: [
                                 
                                      AnimatedScale(
                                        duration: const Duration(milliseconds: 200),
                                        scale: ref.isEditing ? 1 : 0,
                                        child: Checkbox.adaptive(
                                          value:
                                              ref.selectedLocationList[index - 1],
                                          onChanged: (x) {
                                            ref.selectedLocationList[index -1] = x!;
                                            ref.refresh();
                                          },
                                        ),
                                      ),
                                 AnimatedPadding(
                                        duration: const Duration(milliseconds: 200),
                                        padding: ref.isEditing
                                            ? EdgeInsets.only(right: 64.0.w) 
                                            : EdgeInsets.only(right: 16.0.w) ,
                                        child: Text(
                                          value.otherLocations[index - 1],
                                          style: context.theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                            : Text(
                                value.favoriteLocation,
                                style: context.theme.textTheme.bodyMedium,
                              ),
                        subtitle: index == 0
                            ? Text(
                                context.localization.translate("favorite location"),
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(
                                        color: context.theme.primaryColor),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  //
}
