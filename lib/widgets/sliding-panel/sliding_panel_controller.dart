import 'package:flutter/material.dart';

class SlidingPanelController {
  //Context
  late final BuildContext context;

  //Animation
  late final AnimationController animationController;
  late final Animation<double> animation;

  //Overlay
  OverlayEntry? _overlay;
  OverlayState? _overlayState;

  //Widget
  Color? barrierColor;
  Widget? overlayWidget;

  //State
  bool _isOpen = false;

  void open() {
    if (!_isOpen) {
      _showOverlay();
    }
    _isOpen = true;
  }

  void close() {
    if (_overlay!.mounted) {
      _overlay!.remove();
      animationController.reset();
    }
    _overlay = null;
    _isOpen = false;
  }

  void _updateOverlay() {
    if (_isOpen) {
      _overlay!.markNeedsBuild();
    }
  }

  void changeBarrierColor(Color color) {
    barrierColor = color;
    _updateOverlay();
  }

  void _showOverlay() {
    _overlayState = Overlay.of(context);

    _overlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: FadeTransition(
                opacity: animation,
                child: ColoredBox(
                  color: barrierColor ?? const Color.fromARGB(150, 18, 18, 18),
                  child: GestureDetector(
                    onTap: () {
                      close();
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizeTransition(
                sizeFactor: animation,
                child: overlayWidget,
              ),
            ),
          ],
        );
      },
    );

    _overlayState!.insert(_overlay!);
    animationController.forward();

    _overlay ??= _overlay;
  }

  bool get isPanelOpen => _isOpen;
}
