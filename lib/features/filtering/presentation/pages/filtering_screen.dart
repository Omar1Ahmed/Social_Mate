import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_tile.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/post_card_widget.dart';

class FilteringScreen extends StatefulWidget {
  const FilteringScreen({super.key});

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Filtering',
            style: TextStyles.inter18BoldBlack,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilteringTile(),
                SizedBox(height: 16),
                //PostCardWidget(deviceInfo: deviceInfo),
                //PostCardWidget(deviceInfo: deviceInfo),
                //PostCardWidget(deviceInfo: deviceInfo),
              ],
            ),
          ),
        ),
      );
    });
  }
}
