import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/admin/presentation/all_reports/ui/widgets/main_report_card.dart';

class ReportsHomeScreen extends StatefulWidget {
  const ReportsHomeScreen({super.key});

  @override
  State<ReportsHomeScreen> createState() => _ReportsHomeScreenState();
}

class _ReportsHomeScreenState extends State<ReportsHomeScreen> {
  // vaiables
  // init state
  // dispose
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: ColorsManager.primaryColor,
              size: deviceInfo.screenWidth * 0.08,
            ),
          ),
          title: Image.asset(
            'assets/images/Title_img.png',
            width: deviceInfo.screenWidth * 0.4,
            height: deviceInfo.screenHeight * 0.06,
            fit: BoxFit.contain,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: deviceInfo.screenWidth * 0.02),
              child: IconButton(
                onPressed: () => context.pushNamed(Routes.adminReportScreen),
                icon: Icon(
                  Icons.search,
                  color: ColorsManager.primaryColor,
                  size: deviceInfo.screenWidth * 0.08,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          //scroll controller to handle scroll
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.symmetric(
              vertical: deviceInfo.screenHeight * 0.02,
              horizontal: deviceInfo.screenWidth * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Posts Reports',
                    style: TextStyles.inter18Regularblack.copyWith(
                        fontSize: deviceInfo.screenWidth * 0.07,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: deviceInfo.screenHeight * 0.01),
              MainReportCard(
                deviceInfo: deviceInfo,
                reportId: 2,
                postId: 1,
                postTitle: 'This is Post title This is Post title Post title',
                reportCategory: 'Spam',
                reportStatus: 'Pending',
                reportDate: '2025/2/15',
                reportedBy: 'Ahmed Ali',
              ),
              MainReportCard(
                reportId: 2,
                deviceInfo: deviceInfo,
                postId: 1,
                postTitle: 'This is Post title This is Post title Post title',
                reportCategory: 'Spam',
                reportStatus: 'Pending',
                reportDate: '2025/2/15',
                reportedBy: 'Ahmed Ali',
              ),
            ],
          ),
        )),
      );
    });
  }
}
