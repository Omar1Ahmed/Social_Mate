import 'package:flutter/material.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/styles.dart';

class BuildOdernNavitem extends StatelessWidget {
  const BuildOdernNavitem({
    super.key,
    required this.deviceInfo,
    required this.tabIndex,
    required this.activeTabIndex,
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final DeviceInfo deviceInfo;
  final int tabIndex;
  final int activeTabIndex;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isActive = tabIndex == activeTabIndex;
    final double iconSize = deviceInfo.localWidth * 0.07;
    final double labelFontSize = deviceInfo.localWidth * 0.035;
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize + (isActive ? deviceInfo.localWidth * 0.01 : 0),
              color: isActive ? Colors.white : Colors.white70,
            ),
            SizedBox(height: deviceInfo.localHeight * 0.005),
            Text(
              label,
              style: TextStyles.inter14Regular.copyWith(
                fontSize: labelFontSize,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
