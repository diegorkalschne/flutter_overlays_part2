import 'package:flutter/material.dart';
import 'package:flutter_overlay/widgets/sliding-panel/sliding_panel_controller.dart';

class SlidingUpPanelWidget extends StatefulWidget {
  const SlidingUpPanelWidget({
    super.key,
    required this.body,
    required this.feedback,
    required this.overlay,
    this.controller,
    this.backgroundColor,
  });

  final Widget body; // O restante da página
  final Widget feedback; // O que será exibido enquanto o Overlay não estiver sendo exibido
  final Widget overlay; // O que será exibido quando o Overlay estiver em exibição
  final SlidingPanelController? controller; //Controller do Overlay
  final Color? backgroundColor; //Cor de background do Overlay

  @override
  State<SlidingUpPanelWidget> createState() => _SlidingUpPanelWidgetState();
}

class _SlidingUpPanelWidgetState extends State<SlidingUpPanelWidget> with SingleTickerProviderStateMixin {
  late SlidingPanelController controller;

  @override
  void initState() {
    super.initState();

    final AnimationController animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final Animation<double> animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linearToEaseOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = widget.controller ?? SlidingPanelController();

      controller
        ..context = context
        ..animationController = animationController
        ..animation = animation
        ..barrierColor = widget.backgroundColor
        ..overlayWidget = widget.overlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isPanelOpen) {
          controller.close();
          return false;
        }

        return true;
      },
      child: Stack(
        children: [
          widget.body,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy < -200) {
                  controller.open();
                }
              },
              child: widget.feedback,
            ),
          ),
        ],
      ),
    );
  }
}
