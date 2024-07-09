import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ittemspages extends ConsumerWidget {
  const ittemspages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text(
        'items Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
