import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DashboardAppImage extends StatefulWidget {
  final String image;
  final double height;
  final double? width;
  final BoxFit fit;
  final String name;

  const DashboardAppImage({
    super.key,
    required this.image,
    required this.height,
    this.width,
    this.fit = BoxFit.fill,
    required this.name,
  });

  @override
  State<DashboardAppImage> createState() => _DashboardAppImageState();
}

class _DashboardAppImageState extends State<DashboardAppImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = IntTween(begin: 100, end: 0).animate(_animationController);
    _animation.addListener(() => setState(() {}));

    Future<void>.delayed(const Duration(milliseconds: 3000), () {
      _animationController.forward();
      Future<void>.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          opacity = 1.0;
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            widget.image,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          left: 15,
          child: Row(
            children: [
              Expanded(
                flex: (136 - _animation.value).toInt() -
                    (widget.width != null ? 20 : 0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.9),
                  ),
                  child: Row(
                    children: [
                      if (_animation.value < 50)
                        const SizedBox(
                          width: 5,
                        ),
                      Expanded(
                        child: _animation.value < 50
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AnimatedOpacity(
                                  opacity: opacity,
                                  duration: const Duration(seconds: 2), //
                                  child: Text(
                                    widget.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              )
                            : const SizedBox(),
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
              ),
              Expanded(
                flex: _animation.value,
                child: const SizedBox(),
              )
            ],
          ),
        )
      ],
    );
  }
}
