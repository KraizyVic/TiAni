import 'package:flutter/material.dart';
class Reaction extends StatelessWidget {
  final String reaction;
  final int metric;
  const Reaction({
    super.key,
    required this.reaction,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(reaction),
        Text(metric.toString()),
      ],
    );
  }
}
