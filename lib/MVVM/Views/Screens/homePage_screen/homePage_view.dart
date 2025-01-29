import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/homePage_screen/widgets/create_post_widget.dart';
import 'package:social_media/Responsive/Models/device_info.dart';
import 'package:social_media/Responsive/ui_component/info_widget.dart';
import 'package:social_media/theming/colors.dart';

import '../../../../theming/styles.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                deviceInfo.screenWidth * 0.05,
                deviceInfo.screenHeight * 0.05,
                deviceInfo.screenWidth * 0.035,
                0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: deviceInfo.screenHeight, // Ensure scrolling works
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Title_img.png',
                          width: deviceInfo.localWidth * 0.5,
                          height: deviceInfo.localHeight * 0.04,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.menu, size: deviceInfo.localWidth * 0.09),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: deviceInfo.localHeight * 0.04),
                    Text(
                      'What’s on your head?',
                      style: TextStyles.inter18Bold.copyWith(fontSize: deviceInfo.localWidth * 0.06),
                    ),
                    SizedBox(height: deviceInfo.localHeight * 0.02),
                    CreatePostWidget(deviceInfo: deviceInfo),
                    SizedBox(height: deviceInfo.localHeight * 0.02),
                    Row(
                      children: [
                        Text(
                          'Feed',
                          style: TextStyles.inter18Bold.copyWith(fontSize: deviceInfo.localWidth * 0.06),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Image.asset(
                            'assets/images/Filters_icon.png',
                            width: deviceInfo.localWidth * 0.09,
                            height: deviceInfo.localWidth * 0.09,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(height: deviceInfo.localHeight * 0.02),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: deviceInfo.localHeight * 0.02),
                          child: Container(
                            width: deviceInfo.localWidth * 0.9,
                            height: deviceInfo.localHeight * 0.33,
                            decoration: BoxDecoration(
                              color: ColorsManager.primaryColor.withOpacity(0.2),
                              border: Border.all(color: ColorsManager.primaryColor.withOpacity(1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
                              child: const Column(), // Your post content goes here
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
