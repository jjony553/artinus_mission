import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;
  const CustomKeyboard(
      {super.key,
      required this.label,
      required this.value,
      required this.onTap});

  @override
  State<CustomKeyboard> createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyboard> {
  checkLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }
    return Text(
      widget.label,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: Container(
        color: Colors.black87,
        child: Center(child: checkLabel()),
      ),
    );
  }
}
