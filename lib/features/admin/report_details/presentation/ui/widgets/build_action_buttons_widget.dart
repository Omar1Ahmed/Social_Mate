import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';

class ActionButtonsWidget extends StatelessWidget {
  final DeviceInfo info;

  const ActionButtonsWidget({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: Size(info.screenWidth * 0.4, info.screenHeight * 0.05),
          ),
          child: Text(
            'Approve',
            style: TextStyle(fontSize: info.screenWidth * 0.04, color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(info.screenWidth * 0.4, info.screenHeight * 0.05),
          ),
          child: Text(
            'Reject',
            style: TextStyle(fontSize: info.screenWidth * 0.04, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
