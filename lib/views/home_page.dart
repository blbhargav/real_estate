import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/bloc/bloc.dart';
import 'package:real_estate/enums/home_nav_item.dart';
import 'package:real_estate/utils/app_colors.dart';
import 'package:real_estate/views/dashboard.dart';
import 'package:real_estate/views/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 3000), () {
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xfffabe76).withOpacity(0.6),
                    Colors.white,
                  ],
                  center: Alignment.centerRight,
                  radius: 1.1,
                ),
              ),
            ),
            SafeArea(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  switch (state.screen) {
                    case HomeNavItem.search:
                      return const SearchScreen();
                    case HomeNavItem.chat:
                      return const SizedBox();
                    case HomeNavItem.dashboard:
                      return const Dashboard();
                    case HomeNavItem.favorite:
                      return const SizedBox();
                    case HomeNavItem.profile:
                      return const SizedBox();
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _animation,
                child: _BottomNavigation(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black,
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BottomNavItem(
                selected: state.screen == HomeNavItem.search,
                icon: Icons.search,
                onTap: () => _onTop(context, HomeNavItem.search),
              ),
              _BottomNavItem(
                selected: state.screen == HomeNavItem.chat,
                icon: Icons.chat,
                onTap: () => _onTop(context, HomeNavItem.chat),
              ),
              _BottomNavItem(
                selected: state.screen == HomeNavItem.dashboard,
                icon: Icons.home_filled,
                onTap: () => _onTop(context, HomeNavItem.dashboard),
              ),
              _BottomNavItem(
                selected: state.screen == HomeNavItem.favorite,
                icon: Icons.favorite,
                onTap: () => _onTop(context, HomeNavItem.favorite),
              ),
              _BottomNavItem(
                selected: state.screen == HomeNavItem.profile,
                icon: Icons.person,
                onTap: () => _onTop(context, HomeNavItem.profile),
              ),
            ],
          );
        },
      ),
    );
  }

  _onTop(BuildContext context, HomeNavItem item) {
    context.read<HomeCubit>().update(screen: item);
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    this.selected = false,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.primaryDark : null,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
