// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
// import 'package:social_media/core/theming/colors.dart';
// import 'package:social_media/core/theming/styles.dart';

// class FilteredPostCard extends StatelessWidget {
//   const FilteredPostCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InfoWidget(builder: (context, deviceInfo) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           width: deviceInfo.screenWidth,
//           height: deviceInfo.screenHeight * 0.2,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: ColorsManager.primaryColor,
//               width: 1,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     'Who ate my dinosour??!',
//                     style: TextStyles.inter18BoldBlack,
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.delete_forever,
//                         color: ColorsManager.redColor,
//                       ))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';

class FilteredPostCard extends StatelessWidget {
  final String title;
  final String postOwner;
  final String date;
  final String content;

  const FilteredPostCard({super.key, required this.title, required this.postOwner, required this.date, required this.content});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorsManager.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      title,
                      style: TextStyles.inter18BoldBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_forever,
                          color: ColorsManager.redColor,
                        )),
                  )
                ],
              ),

              Divider(
                color: Colors.black,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                     postOwner,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Row(
                    children: [
                       Text(
                        date,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

               Text(
                content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Show more"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Report"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
