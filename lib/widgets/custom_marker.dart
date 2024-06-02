import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final Color color;
  final String label;

  const CustomMarker({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: GlobalKey(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
