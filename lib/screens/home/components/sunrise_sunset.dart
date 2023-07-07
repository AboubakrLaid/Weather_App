import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';
import 'package:weather_icons/weather_icons.dart';

class SunSetRise extends StatelessWidget {
  const SunSetRise({super.key, required this.time, required this.isSunRise});
  final String time;
  final bool isSunRise;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: isSunRise ? null : 22.w,
      left: isSunRise ? 22.w : null,
      bottom: isSunRise ? 65.h : 28.h,
      child: Row(
        children: [
          Icon(
            isSunRise ? WeatherIcons.sunrise : WeatherIcons.sunset,
            color:
                isSunRise ? const Color(0xFFFFC300) : const Color(0xFFFD7F14),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.only(top: 15.w),
            child: Text(
                time,
                style: context.theme.textTheme.labelSmall,
              ),
            
          ),
        ],
      ),
    );
  }
}
