import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      elevation: 0,
      // insetPadding: const EdgeInsets.symmetric(horizontal: 150),
      child: Center(
    
        child: SizedBox.square(
          dimension: 60,
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
