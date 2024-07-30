import 'package:flutter/material.dart';

class OptionCardWidget extends StatelessWidget {
  const OptionCardWidget({
    super.key,
    required this.option,
    required this.onTap,
    required this.color,
  });

  final String option;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: ListTile(
          title: Text(
            option,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
