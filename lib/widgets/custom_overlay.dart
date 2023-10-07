import 'package:flutter/material.dart';
import 'package:flutter_overlay/widgets/overlay_feedback.dart';
import 'package:flutter_overlay/widgets/sliding-panel/sliding_panel_controller.dart';

class CustomOverlay extends StatelessWidget {
  const CustomOverlay({
    required this.controller,
    super.key,
  });

  final SlidingPanelController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[800],
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20).copyWith(top: 0),
        child: Column(
          children: [
            const OverlayFeedback(),
            const SizedBox(height: 20),
            const Text(
              'This is my custom overlay',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.changeBarrierColor(const Color.fromARGB(128, 147, 198, 242));
              },
              child: const Text('Change Barrier Color'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.close();
              },
              child: const Text('Close Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
