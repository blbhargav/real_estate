import 'package:flutter/material.dart';
import 'package:real_estate/utils/app_colors.dart';

class SearchMenuItemTile extends StatelessWidget {
  const SearchMenuItemTile({
    super.key,
    required this.icon,
    required this.name,
    required this.selected,
  });
  final IconData icon;
  final String name;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Icon(
          icon,
          color: selected ? AppColors.primaryColor : AppColors.iconColor,
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          name,
          style: TextStyle(
            color: selected ? AppColors.primaryColor : AppColors.iconColor,
          ),
        ),
      ],
    );
  }
}
