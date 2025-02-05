import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';

import '../../../../../core/di/di.dart';

class post_details_screen extends StatefulWidget {
  @override
  State createState() => _post_details_screenState();
}

class _post_details_screenState extends State<post_details_screen> {
  final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Scaffold(
        body: Center(
          child: Text(_sharedPrefHelper.getString(SharedPrefKeys.testKey) ?? 'no Data'),
        ),
      );
    });
  }
}
