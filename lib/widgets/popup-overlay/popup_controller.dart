import 'package:flutter/material.dart';

class PopupController {
  //Context
  late final BuildContext context;

  //Overlay
  OverlayEntry? _overlay;
  OverlayState? _overlayState;

  //State
  bool _isOpen = false;
  late final GlobalKey key;
  double _sliderValue = 0;
  late void Function(double) onChanged;

  void open() {
    if (!_isOpen) {
      _showOverlay();
    }
    _isOpen = true;
  }

  void close() {
    if (_overlay!.mounted) {
      _overlay!.remove();
    }
    _overlay = null;
    _isOpen = false;
  }

  void _updateOverlay() {
    if (_isOpen) {
      _overlay!.markNeedsBuild();
    }
  }

  void _showOverlay() {
    _overlayState = Overlay.of(context);

    //Obtendo posições e tamanho do Widget
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: offset.dy + size.height, //Exibindo o Overlay logo abaixo do Widget
          left: offset.dx,
          child: GestureDetector(
            onTap: () {
              close();
            },
            child: Material(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Slider(
                  value: _sliderValue,
                  onChanged: (value) {
                    _sliderValue = value;
                    onChanged(value);
                    _updateOverlay();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    _overlayState!.insert(_overlay!);
  }
}
