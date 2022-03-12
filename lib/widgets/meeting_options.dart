import 'package:flutter/material.dart';
import 'package:zoom_clone/utilities/colors.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool mute;
  final Function(bool) onChanged;
  const MeetingOption({
    Key? key,
    required this.text,
    required this.mute,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgrounndColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
          Switch.adaptive(
            value: mute,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
