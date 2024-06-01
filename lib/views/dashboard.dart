import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/utils/app_colors.dart';

import '../widgets/dashboard_location_widget.dart';
import '../widgets/dashbord_app_image.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;
  double avatharSize = 0.0;
  double counterCardSize = 0.0;
  void toggleOpacity() {
    setState(() {
      opacity = 1.0;
      avatharSize = 60;
      counterCardSize = 160;
    });
  }

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 1), () {
      toggleOpacity();
    });
    Future<void>.delayed(const Duration(seconds: 2), () {
      _controller.forward();
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Start just below the screen
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DashboardLocationWidget(),
              SizedBox(
                width: 60,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: avatharSize,
                    height: avatharSize,
                    child: CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        'assets/images/avathar.png',
                        width: 60,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 2), //
            child: const Text(
              'Hi, Marina',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DelayedWidget(
            delayDuration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(seconds: 1), // Not required
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM, // Not required
            child: const Text(
              "let's select your",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DelayedWidget(
            delayDuration: const Duration(milliseconds: 1500), // Not required
            animationDuration: const Duration(seconds: 1), // Not required
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM, // Not required
            child: const Text(
              "perfect place",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: counterCardSize,
                    height: counterCardSize,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryDark,
                      ),
                      width: 160,
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'BUY',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TweenAnimationBuilder<int>(
                                      tween: IntTween(
                                          begin: 0,
                                          end:
                                              1034), // Define the range of the counter
                                      duration: const Duration(
                                          seconds:
                                              3), // Duration of the animation
                                      builder: (context, value, child) {
                                        return Text(
                                          '$value',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'offers',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                height: 160,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: counterCardSize,
                    height: counterCardSize,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      width: 160,
                      height: 160,
                      child: Column(
                        children: [
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'RENT',
                              style:
                                  TextStyle(color: AppColors.primaryTextColor),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TweenAnimationBuilder<int>(
                                      tween: IntTween(
                                          begin: 0,
                                          end:
                                              2213), // Define the range of the counter
                                      duration: const Duration(
                                          seconds:
                                              3), // Duration of the animation
                                      builder: (context, value, child) {
                                        return Text(
                                          '$value',
                                          style: const TextStyle(
                                            color: AppColors.primaryTextColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'offers',
                                      style: TextStyle(
                                          color: AppColors.primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SlideTransition(
          position: _animation,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                DashboardAppImage(
                  image: 'assets/images/living_room.jpeg',
                  height: 200,
                  width: double.maxFinite,
                  name: 'Gladkova St., 25',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DashboardAppImage(
                        image: 'assets/images/room.jpeg',
                        height: 410,
                        fit: BoxFit.fitHeight,
                        name: 'Gubina St., 11',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          DashboardAppImage(
                            image: 'assets/images/room3.jpeg',
                            height: 200,
                            name: 'Trefoleva St., 43',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DashboardAppImage(
                            image: 'assets/images/bed_room2.jpeg',
                            height: 200,
                            name: 'Sedova St., 22',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
