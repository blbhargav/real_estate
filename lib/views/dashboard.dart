import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/utils/app_colors.dart';

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
              Container(
                height: 40,
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
                child: const Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: AppColors.primaryTextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Saint Petersburg',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                      ),
                    )
                  ],
                ),
              ),
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
                      child: const Column(
                        children: [
                          FittedBox(
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
                                    child: Text(
                                      '1034',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
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
                      child: const Column(
                        children: [
                          FittedBox(
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
                                    child: Text(
                                      '2213',
                                      style: TextStyle(
                                        color: AppColors.primaryTextColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
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
                _AppImage(
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
                      child: _AppImage(
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
                          _AppImage(
                            image: 'assets/images/room3.jpeg',
                            height: 200,
                            name: 'Trefoleva St., 43',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _AppImage(
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

class _AppImage extends StatelessWidget {
  final String image;
  final double height;
  final double? width;
  final BoxFit fit;
  final String name;

  const _AppImage({
    super.key,
    required this.image,
    required this.height,
    this.width,
    this.fit = BoxFit.fill,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            image,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          left: 15,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withOpacity(0.9),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
