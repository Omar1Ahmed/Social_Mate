import 'package:flutter/material.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';


class BuildErrorWidget extends StatelessWidget {
  const BuildErrorWidget({super.key, required this.deviceInfo});
  final DeviceInfo deviceInfo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong! refresh the page',
            style: TextStyle(
              fontSize: deviceInfo.localWidth * 0.04,
              color: Colors.red,
            ),
          ),
          SizedBox(height: deviceInfo.localHeight * 0.02),
        ],
      ),
    );
  }
}
