import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/model/jwtModel.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/repository/jwt_token_decode_repository_imp.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/delete_dialoge.dart';
import 'package:social_media/features/filtering/presentation/widgets/report_dialog_marwan.dart';

class FilteredPostCard extends StatefulWidget {
  final int postId;
  final int postOwnerId;
  final String title;
  final String postOwner;
  final String date;
  final String content;

  const FilteredPostCard(
      {super.key,
      required this.title,
      required this.postOwner,
      required this.date,
      required this.content,
      required this.postOwnerId,
      required this.postId});

  @override
  State<FilteredPostCard> createState() => _FilteredPostCardState();
}

class _FilteredPostCardState extends State<FilteredPostCard> {
  final JwtTokenDecodeRepositoryImp decodedToken =
      getIt.get<JwtTokenDecodeRepositoryImp>();
  late final JwtModel decodedTokenFromChache;

  @override
  void initState() {
    super.initState();
    decodedTokenFromChache = decodedToken.decodeToken(
        getIt.get<SharedPrefHelper>().getString(SharedPrefKeys.saveKey)!);
  }

  double _localRating = 0.0;
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
                      widget.title,
                      style: TextStyles.inter18BoldBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    //TODO: icon only shown if postOwnerId = currentUserId , need to pass currentUserId
                    child: Visibility(
                      visible:
                          (decodedTokenFromChache.userId == widget.postOwnerId),
                      child: IconButton(
                          onPressed: () {
                            deleteDialog(
                              context,
                              widget.postId,
                              deviceInfo,
                            );
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: ColorsManager.redColor,
                          )),
                    ),
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
                    widget.postOwner,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.date,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(widget.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18, color: const Color.fromARGB(255, 7, 7, 7))),

              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingStars(
                    value: _localRating, // Use local rating state
                    onValueChanged: (value) {
                      setState(() {
                        _localRating = value; // Update local rating state
                      });
                      // Optionally send the rating to the backend or update the post entity
                      // getIt.get<HomeCubit>().updatePostRating(widget.post.id, value);
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                      size: deviceInfo.screenWidth * 0.05,
                    ),
                    starCount: 5,
                    starSize: deviceInfo.screenWidth * 0.04,
                    valueLabelVisibility: false,
                  ),
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => ReportDialogMarwan(
                                deviceInfo: deviceInfo,
                              ));
                    },
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
