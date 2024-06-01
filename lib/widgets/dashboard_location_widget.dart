import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DashboardLocationWidget extends StatefulWidget {
  const DashboardLocationWidget({super.key});

  @override
  State<DashboardLocationWidget> createState() =>
      _DashboardLocationWidgetState();
}

class _DashboardLocationWidgetState extends State<DashboardLocationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = IntTween(begin: 0, end: 220).animate(_animationController);
    _animation.addListener(() => setState(() {
          if (_animationController.isCompleted) {
            opacity = 1.0;
          }
        }));

    Future<void>.delayed(const Duration(milliseconds: 1000), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: (_animation.value).toDouble(),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryColor,
          ),
          BoxShadow(
            color: AppColors.primaryColor,
            spreadRadius: -2.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: (_animation.value >= 220)
          ? AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 2),
              child: const Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    color: AppColors.primaryTextColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Saint Petersburg',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
