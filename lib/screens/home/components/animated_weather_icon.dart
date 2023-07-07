import 'package:flutter/material.dart';
import 'package:weather/screens/home/components/weather_icon.dart';

class AnimatedWeatherIcon extends StatefulWidget {
  const AnimatedWeatherIcon({super.key, required this.size, required this.id,  this.pod});
  final double size;
  final int id;
  final String? pod;

  @override
  State<AnimatedWeatherIcon> createState() => _AnimatedWeatherIconState();
}

class _AnimatedWeatherIconState extends State<AnimatedWeatherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
     super.initState();
    if (mounted) {
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500))..forward()..repeat(reverse: true);
      
    }
  
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    //
    //
    return ScaleTransition(
     
      scale: Tween<double>(begin: 1.0, end: 1.08).animate(_animationController),
      child: Icon(
        weatherIcon(context, widget.id, pod: widget.pod),
        size: widget.size,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
