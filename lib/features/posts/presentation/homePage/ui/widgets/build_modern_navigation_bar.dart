import 'package:flutter/material.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/build_odern_navItem.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';

class BuildModernNavigationBar extends StatelessWidget {
  final DeviceInfo deviceInfo;
  const BuildModernNavigationBar({super.key, required this.deviceInfo});

  @override
  Widget build(BuildContext context) {
    final double navBarHeight = deviceInfo.localHeight * 0.08;
    int activeTabIndex = 0;
    return Container(
      height: navBarHeight,
      margin: EdgeInsets.symmetric(
        horizontal: deviceInfo.localWidth * 0.01,
        vertical: deviceInfo.localHeight * 0.01,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor.withOpacity(0.8),
            ColorsManager.primaryColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BuildOdernNavitem(
            deviceInfo: deviceInfo,
            tabIndex: 0,
            activeTabIndex: activeTabIndex,
            icon: Icons.home,
            label: 'Home',
            onPressed: () => _onTabSelected(context, 0),
          ),
          BuildOdernNavitem(
            deviceInfo: deviceInfo,
            tabIndex: 1,
            activeTabIndex: activeTabIndex,
            icon: Icons.person,
            label: 'Profile',
            onPressed: () => _onTabSelected(context, 1),
          ),
          BuildOdernNavitem(
            deviceInfo: deviceInfo,
            tabIndex: 2,
            activeTabIndex: activeTabIndex,
            icon: Icons.settings,
            label: 'Settings',
            onPressed: () => _onTabSelected(context, 2),
          ),
        ],
      ),
    );
  }

  void _onTabSelected(BuildContext context, int tabIndex) {
    print('Tab $tabIndex selected');
    switch (tabIndex) {
      case 0:
        // Navigate to Home screen
        break;
      case 1:
        // Navigate to Profile screen
        break;
      case 2:
        // Navigate to Settings screen
        break;
    }
  }
}
