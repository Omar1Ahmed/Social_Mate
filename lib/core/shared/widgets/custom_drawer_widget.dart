import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/shared/widgets/log_out_dialog.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key, required this.inMemberView});
  final bool inMemberView;
  Widget buildDrawerListItem({required IconData leadingIcon, required String title, Widget? triling, Function()? onTap, Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? Colors.blue,
      ),
      title: Text(title),
      trailing: triling ??
          const Icon(
            Icons.arrow_right,
            color: Colors.blue,
          ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final userName = getIt<userMainDetailsCubit>().state.userId;  get user name from cubit
    return InfoWidget(
      builder: (context, deviceInfo) {
        return Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: ColorsManager.primaryColor,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(height: 10),
                    // get user name from cubit
                    const Text(
                      'User Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              inMemberView
                  ? buildDrawerListItem(
                      leadingIcon: Icons.dashboard,
                      title: 'Reports',
                      onTap: () {
                        // navigate to reports screen
                        context.pushReplacementNamed(Routes.reportsHomeScreen);
                      },
                    )
                  : buildDrawerListItem(
                      leadingIcon: Icons.home,
                      title: 'Home',
                      onTap: () {
                        // navigate to home screen
                        context.pushReplacementNamed(Routes.homePage);
                      },
                    ),
              buildDrawerListItem(
                leadingIcon: Icons.person,
                title: 'Logout',
                color: Colors.red,
                onTap: () {
                  // logout
                  logOutDialog(context, deviceInfo);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
