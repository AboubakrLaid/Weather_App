// print(DateTime.fromMillisecondsSinceEpoch(json.dt,isUtc: true).add(Duration(seconds: json.timeZone)));
import 'package:flutter/material.dart';
import 'package:weather/screens/home/components/sunrise_sunset.dart';
import 'package:weather/screens/home/curved_line/curved_line.dart';
import 'package:weather/screens/home/home_body.dart';
import 'package:weather/screens/search_locations/search.dart';
import 'package:weather/util/blue_border.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';
import 'package:jiffy/jiffy.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  String getTime(int milliseconds, int timeZone) {
    return Jiffy.parseFromDateTime(
      DateTime.fromMillisecondsSinceEpoch(
        milliseconds * 1000,
        isUtc: true,
      ).add(
        Duration(
          seconds: timeZone,
        ),
      ),
    ).format(pattern: "HH:mm");
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(0, 0), end:  Offset(appLanguage.isArabic?-0.8 : 0.8, 0))
              .animate(_animationController),
      child: Scaffold(
        // key: GlobalKey(),
        drawerEnableOpenDragGesture: false,

        body: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              floating: true,
              snap: true,
              pinned: true,
              stretch: true,
              expandedHeight: 180.h,
              onStretchTrigger: () async {
                // print("is refreshing");
              },
              title: FittedBox(
                child: Text(
                  Jiffy.now().format(pattern: "EE, MMM d"),
                  style: context.theme.textTheme.displayMedium,
                ),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 85),
                  child: Stack(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<WeatherData>(
                        builder: (context, value, child) => SunSetRise(
                          time: getTime(
                            value.currentWeatherData!.sys.sunrise,
                            value.currentWeatherData!.timeZone,
                          ),
                          isSunRise: true,
                        ),
                      ),
                      SizedBox(
                        width: kWidth,
                        height: 200.h,
                        child: CustomPaint(painter: CurvedLine()),
                      ),
                      Consumer<WeatherData>(
                        builder: (context, value, child) => SunSetRise(
                          time: getTime(
                            value.currentWeatherData!.sys.sunset,
                            value.currentWeatherData!.timeZone,
                          ),
                          isSunRise: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchLocation(),
                      useRootNavigator: true,
                    );
                  },
                  icon: Icon(
                    LineIcons.search,
                    size: 30,
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
              leading: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    _animationController.forward();
                    context.pushNamed(
                      "SliderDrawer",
                      extra: _animationController,
                    );
                  },
                  child: BlueBorder(
                    AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: Tween<double>(begin: 1.0, end: 0.0)
                          .animate(_animationController),
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const HomeBody()
          ],
        ),
      ),
    );
  }
}
