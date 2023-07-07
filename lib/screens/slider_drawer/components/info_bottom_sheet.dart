import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';

class InfoBottomSheet extends StatefulWidget {
  const InfoBottomSheet({super.key});

  @override
  State<InfoBottomSheet> createState() => _InfoBottomSheetState();
}

class _InfoBottomSheetState extends State<InfoBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: kWidth,
        child: Text(
          context.localization.translate("Each time you launch the application, the home screen prominently displays your favorite location.\n You can change your favorite location in your location list."),
          style: context.theme.textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      
    );
  }
}
