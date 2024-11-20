import 'package:flutter/material.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool on = true;

  void toggleSwitch() {
    setState(() {
      on = !on;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: on,
        activeColor: Colors.white,
        activeTrackColor: const Color.fromRGBO(73, 161, 249, 1),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color.fromRGBO(255, 128, 158, 1),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        onChanged: (value) {
          toggleSwitch();
        },
      ),
    );
  }
}
