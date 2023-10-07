// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_overlay/widgets/custom_overlay.dart';
import 'package:flutter_overlay/widgets/overlay_feedback.dart';
import 'package:flutter_overlay/widgets/popup-overlay/popup_widget.dart';
import 'package:flutter_overlay/widgets/sliding-panel/sliding_panel_controller.dart';
import 'package:flutter_overlay/widgets/sliding-panel/sliding_up_panel_widget.dart';

void main() => runApp(const OverlayApp());

class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overlay App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = SlidingPanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay App'),
        centerTitle: true,
      ),
      body: SlidingUpPanelWidget(
        controller: controller,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is the body of my application',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.open();
                },
                child: const Text('Open Overlay'),
              ),
              const SizedBox(height: 10),
              PopupWidget(
                callback: (value) {
                  print(value);
                },
                child: const Card(
                  color: Colors.blue,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Open PopUp Overlay'),
                  ),
                ),
              ),
            ],
          ),
        ),
        feedback: const OverlayFeedback(),
        overlay: CustomOverlay(controller: controller),
      ),
    );
  }
}
