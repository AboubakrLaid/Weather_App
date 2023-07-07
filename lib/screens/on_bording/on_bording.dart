import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/util/export.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Tween<double> _tween = Tween<double>(begin: 0, end: 1);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 370),
    )..forward();
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(5, 7, 20, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kHeight * 0.07),
              TextButton(
              onPressed: ()  => appLanguage.switchLocale(),
              style: TextButton.styleFrom(alignment: Alignment.center),
              child: Text(
                context.localization.translate(
                  appLanguage.isArabic ? "English" : "Arabic",
                ),
                style: context.theme.textTheme.displayMedium!
                    .copyWith(color: context.theme.primaryColor),
              ),
            ),
              SizedBox(height: kHeight * 0.2),
              Expanded(
                child: FadeTransition(
                  opacity: _tween.animate(_animationController),
                  child: PhysicalModel(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(0, 0, 0, 0),
                    shadowColor: context.theme.primaryColor,
                    elevation: 10.0,
                    child: SizedBox(
                      width: kWidth * 0.98,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SvgPicture.asset(
                          "images/on_bording.svg",
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kHeight * 0.15),
              FittedBox(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.localization.translate("Always be"),
                        style: context.theme.textTheme.displayLarge,
                      ),
                      TextSpan(
                        text: context.localization.translate(" prepared"),
                        style: context.theme.textTheme.displayLarge
                            ?.copyWith(color: context.theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kHeight * 0.07),
              ElevatedButton(
                onPressed: ()  => context.pushNamed("Location"),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                  // verticalDirection: VerticalDirection.up,// appLanguage.verticalDirection,
                    children: [
                      Text(
                        context.localization.translate("let's get started"),
                        style: context.theme.textTheme.labelLarge,
                      ),
                      const SizedBox(width: 5),
                      IconTheme(
                        data: context.theme.iconTheme,
                        child: const Icon(LineIcons.arrowRight),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  //
  //
  //
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
