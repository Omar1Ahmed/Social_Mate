import 'package:flutter/material.dart';
import 'package:social_media/core/di/di.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../logic/cubit/home_cubit_cubit.dart';

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
            'Something went wrong!',
            style: TextStyle(
              fontSize: deviceInfo.localWidth * 0.04,
              color: Colors.red,
            ),
          ),
          SizedBox(height: deviceInfo.localHeight * 0.02),
          ElevatedButton(
            onPressed: () {
              getIt<HomeCubit>().getPosts();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
              ),
            ),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
