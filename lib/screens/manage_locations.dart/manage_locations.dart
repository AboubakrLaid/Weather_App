import 'package:flutter/material.dart';
import 'package:weather/screens/manage_locations.dart/footer_buttons.dart';
import 'package:weather/screens/manage_locations.dart/manage_body.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/blue_border.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/weather_data.dart';

class ManageLocations extends StatelessWidget {
  const ManageLocations({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<Refresh>(context, listen: false);
    final state = Provider.of<WeatherData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: BlueBorder(
            Icon(
             appLanguage.isArabic?LineIcons.arrowRight : LineIcons.arrowLeft,
              color: context.theme.primaryColor,
            ),
          ),
        ),
        title: FittedBox(
          child: Text(
            context.localization.translate("Manage locations"),
            style: context.theme.textTheme.displayMedium,
          ),
        ),
        actions: [
          if (state.otherLocations.isNotEmpty)
            PopupMenuButton(
              icon: Icon(
                LineIcons.verticalEllipsis,
                color: context.theme.primaryColor,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child:  Text(context.localization.translate("Edit")),
                    onTap: () {
                      ref.isEditing = !ref.isEditing;
                      ref.refresh();
                    },
                  ),
                ];
              },
            )
        ],
      ),
      //
      //
      //
      body: const ManageLocationBody(),
      //
      //
      //
      //
      //
      persistentFooterAlignment: AlignmentDirectional.centerStart,

      persistentFooterButtons: const [
        FooterButton(),
      ],

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
                        context.localization.translate("No internet connection"),
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
