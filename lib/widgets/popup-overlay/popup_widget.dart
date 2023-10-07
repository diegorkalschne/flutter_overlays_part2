import 'package:flutter/material.dart';
import 'package:flutter_overlay/widgets/popup-overlay/popup_controller.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    required this.child,
    required this.callback,
    super.key,
  });

  final Widget child;
  final void Function(double) callback;

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  late final PopupController controller;
  final key = GlobalKey();
  double value = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = PopupController();

      controller
        ..context = context
        ..key = key
        ..onChanged = (value) {
          setState(() {
            this.value = value;
          });
          widget.callback(value);
        };
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () => controller.open(),
      child: Column(
        children: [
          widget.child,
          Text('Value: ${value.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
