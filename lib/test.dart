import 'package:flutter/material.dart';

import 'package:weather/localization/app_localizations.dart';
import 'package:weather/util/globale_variables.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("first")
        ),
      ),
      body:  Center(
        child: Column(
          children: [
            Text(
              context.localization.translate("second")
            ),
            TextButton(onPressed: ()=> appLanguage.switchLocale(), child:  const Text('call'))
          ],
        ),
      ),
    );
  }
}
