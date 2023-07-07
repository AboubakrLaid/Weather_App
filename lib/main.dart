import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/screens/retrive_data.dart/retriving_data.dart';
import 'package:weather/services/connectivity_service.dart';
import 'package:weather/util/export.dart';
import 'package:weather/util/refresh.dart';
import 'package:weather/view_models/fetch_weather.dart';
import 'package:weather/view_models/weather_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init theme mode from app theme
  bool? temp = await localDB.isDarkMode();
  appTheme.initThemeMode = temp == null
      ? ThemeMode.system
      : (temp == true ? ThemeMode.dark : ThemeMode.light);

  // init the default screen
  bool isSeen = await localDB.hasSeenOnboarding() ?? false;
  if (isSeen) {
    defaultScreen = const RetrivingData();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConnectivityService x;
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() => setState(() {}));
    appLanguage.addListener(() => setState(() {}));

    x = ConnectivityService();
    _init();
  }

  _init() async {
    await ConnectivityService.initIsDeviceConnected();
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WeatherData()),
          ChangeNotifierProvider(create: (context) => Refresh()),
          ChangeNotifierProvider(create: (context) => FetchWeather()),
        ],
        child: MaterialApp.router(
          color: context.theme.scaffoldBackgroundColor,
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: appTheme.lightTheme,
          darkTheme: appTheme.darkTheme,
          themeMode: appTheme.themeMode,
          themeAnimationCurve: Curves.ease,

          supportedLocales: appLanguage.supportedLocales,

          locale:appLanguage.currentLocale,

          localizationsDelegates: const [
            // loads the translations from json files of lang folder
            AppLocalizations.delegate,
            // built-in localizations of basic text for material widgets
            GlobalMaterialLocalizations.delegate,
            // same thing but for cupertino widgets
            GlobalCupertinoLocalizations.delegate,
            // responsibale for text direction LTR/ RTL
            GlobalWidgetsLocalizations.delegate,
            // AppLocalozation.
          ],

          // returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // check if the current device locale is supported
            if (locale != null) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return locale;
                }
              }
            }
            // if the device local is not supported then
            // returns Locale("en") from supported locales
            return supportedLocales.first;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    appTheme.dispose();
    x.close();
    super.dispose();
  }
}
