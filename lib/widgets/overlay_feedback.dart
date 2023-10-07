import 'package:flutter/material.dart';

class OverlayFeedback extends StatelessWidget {
  const OverlayFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Container(
        height: 5,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
      ),
    );
  }
}
