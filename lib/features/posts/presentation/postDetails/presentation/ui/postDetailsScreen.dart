import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/Shimmer/ShimmerStyle.dart';
import 'package:social_media/core/shared/widgets/cherryToast/CherryToastMsgs.dart';
import 'package:social_media/core/shared/widgets/postDetailsPostCard.dart';

import 'package:social_media/core/shared/widgets/show_report_post_dialog_widget.dart';
import 'package:social_media/core/shared/widgets/animation/slide_Transition__widget.dart';
import 'package:social_media/core/shared/widgets/animation/tween_animation_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';
import 'package:social_media/core/shared/widgets/CommentCard.dart';

class post_details_screen extends StatefulWidget {
  @override
  State createState() => _post_details_screenState();
}

class _post_details_screenState extends State<post_details_screen> {
  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
    print('initState');
    context.read<PostDetailsCubit>().getPostDetails();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return SafeArea(
          child: BlocConsumer<PostDetailsCubit, PostDetailsState>(listener: (context, state) {
        print('state : $state');

        if (state is PostDetailsLoaded) {
          Future.wait(
            [
              context.read<PostDetailsCubit>().getPostCommentsCount(),
              context.read<PostDetailsCubit>().getPostRateAverage(),
              context.read<PostDetailsCubit>().getPostComments(),
            ],
          );
        }
        if (state is SuccessPostRate) {
          context.read<PostDetailsCubit>().getPostRateAverage();
          CherryToastMsgs.CherryToastSuccess(
            info: info,
            context: context,
            title: 'Success!!',
            description: 'You Rated The Post Successfully',
          );
        }

        if (state is FailPostRate) {
          CherryToastMsgs.CherryToastError(
            info: info,
            context: context,
            title: 'Failed!!',
            description: 'You Rated The Post Failed',
          );
        }

        if (state is GiveReactionSuccess) {
          CherryToastMsgs.CherryToastSuccess(
            info: info,
            context: context,
            title: 'Success!!',
            description: 'You Reacted To The Comment Successfully',
          );
        }

        if (state is GiveReactionFail) {
          CherryToastMsgs.CherryToastError(
            info: info,
            context: context,
            title: 'Failed!!',
            description: 'You Reacted To The Comment Failed',
          );
        }

        if (state is CommentsCreated) {
          Future.wait(
            [
              context.read<PostDetailsCubit>().getPostCommentsCount(),
              context.read<PostDetailsCubit>().getPostComments(),
            ],
          );
          CherryToastMsgs.CherryToastSuccess(
            info: info,
            context: context,
            title: 'Success!!',
            description: 'Your Comment is Successfully sent',
          );
        }

        if (state is CommentsError) {
          CherryToastMsgs.CherryToastError(
            info: info,
            context: context,
            title: 'Failed!!',
            description: state.message,
          );
        }
      }, builder: (context, state) {
        final postDetailsCubit = context.read<PostDetailsCubit>();
        final userMainDetails = context.read<userMainDetailsCubit>();
        return Scaffold(
          backgroundColor: ColorsManager.whiteColor,
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: info.screenHeight * 0.019),
                        child: Column(
                          children: [
                            _buildHeader(info, context),
                            Divider(
                              height: info.localHeight * 0.01,
                              thickness: info.screenWidth * 0.001,
                              color: ColorsManager.greyColor,
                            ),
                            PostDetailsPostCard(
                              info: info,
                              isTitleShimmer: state is PostDetailsLoading || state is PostDetailsInitial,
                              titleText: postDetailsCubit.post?.title,
                              showDeleteButton: userMainDetails.state.userId == postDetailsCubit.post?.createdBy.id,
                              DeleteButtonOnPressed: () {
                                print('Pressed');
                              },
                              isNameAndDateShimmer: state is PostDetailsLoading || state is PostDetailsInitial,
                              fullNameText: postDetailsCubit.post?.createdBy.fullName,
                              formattedDateText: postDetailsCubit.post?.FormattedDate,
                              showReportButton: true,
                              ReportButtonOnPressed: () {
                                print('report Pressed');
                              },
                              isContentShimmer: state is PostDetailsLoading || state is PostDetailsInitial,
                              contentText: postDetailsCubit.post?.content,
                              isCommentsCountShimmer: postDetailsCubit.commentsCount == null,
                              commentsCountText: '${postDetailsCubit.commentsCount} comments',
                              isRateAverageShimmer: postDetailsCubit.rateAverage == null,
                              rateAverageText: '${postDetailsCubit.rateAverage} Rate',
                              showStars: true,
                              SelectedRatingValue: postDetailsCubit.selectedRatingValue,
                              setRateAverage: (postDetailsCubit.setRateAverage),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02, start: info.screenWidth * 0.02),
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Comments',
                                style: TextStyles.inter18BoldBlack.copyWith(
                                  fontSize: info.screenWidth * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    postDetailsCubit.comments == null
                        ? SliverToBoxAdapter(
                            child: customShimmer(
                                childWidget: Column(children: [
                            Container(
                                width: info.screenWidth * 0.9,
                                height: info.screenHeight * 0.13,
                                margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(info.screenWidth * 0.07),
                                    bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                    bottomRight: Radius.circular(info.screenWidth * 0.07),
                                  ),
                                )),
                            SizedBox(
                              height: info.screenHeight * 0.01,
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                ),
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                )
                              ],
                            ),
                            Container(
                                width: info.screenWidth * 0.9,
                                height: info.screenHeight * 0.13,
                                margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(info.screenWidth * 0.07),
                                    bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                    bottomRight: Radius.circular(info.screenWidth * 0.07),
                                  ),
                                )),
                            SizedBox(
                              height: info.screenHeight * 0.01,
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                ),
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                )
                              ],
                            ),
                            Container(
                                width: info.screenWidth * 0.9,
                                height: info.screenHeight * 0.13,
                                margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                                padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.05, end: info.screenWidth * 0.05, top: info.screenHeight * 0.01, bottom: info.screenHeight * 0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(info.screenWidth * 0.07),
                                    bottomLeft: Radius.circular(info.screenWidth * 0.07),
                                    bottomRight: Radius.circular(info.screenWidth * 0.07),
                                  ),
                                )),
                            SizedBox(
                              height: info.screenHeight * 0.01,
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                ),
                                Container(margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02), width: info.screenWidth * 0.05, height: info.screenHeight * 0.015, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.025))),
                                Container(
                                  width: info.screenWidth * 0.08,
                                  height: info.screenHeight * 0.035,
                                  margin: EdgeInsetsDirectional.only(start: info.screenWidth * 0.02),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(info.screenWidth * 0.09)),
                                )
                              ],
                            ),
                          ])))
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: postDetailsCubit.comments!.length == 0 ? 1 : postDetailsCubit.comments!.length,
                              (context, index) => postDetailsCubit.comments!.length > 0
                                  ? TweenAnimationWidget(
                                      index: index,
                                      deviceInfo: info,
                                      child: SlideTransitionWidget(
                                          child: CommentCard(
                                        comment: postDetailsCubit.comments![index],
                                        info: info,
                                      )),
                                    )
                                  : Container(
                                      margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.08),
                                      width: info.screenWidth * 0.6,
                                      height: info.screenHeight * 0.3,
                                      child: Image.asset('assets/images/noComments.png'),
                                    ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: info.screenHeight * 0.076,
                padding: EdgeInsetsDirectional.only(bottom: info.screenHeight * 0.007, top: info.screenHeight * 0.007),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: info.screenWidth * 0.85,
                      padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.04, end: info.screenWidth * 0.01),
                      child: TextField(
                        controller: postDetailsCubit.createCommentController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorsManager.lightGreyColor,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(info.screenWidth * 0.05), borderSide: BorderSide.none),
                          hintText: 'Add comment',
                        ),
                        textInputAction: TextInputAction.send,
                        focusNode: focusNode,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(focusNode);
                          postDetailsCubit.createComment(context);
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          postDetailsCubit.createComment(context);
                        },
                        icon: Icon(
                          Icons.send,
                          color: ColorsManager.primaryColor,
                          size: info.screenWidth * 0.08,
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      }));
    });
  }

  Widget _buildHeader(DeviceInfo deviceInfo, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.localWidth * 0.02,
        vertical: deviceInfo.localHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/Title_img.png',
            width: deviceInfo.localWidth * 0.48,
            height: deviceInfo.localHeight * 0.06,
            fit: BoxFit.contain,
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     size: deviceInfo.screenWidth * 0.08,
          //     color: ColorsManager.primaryColor,
          //   ),
          //   onPressed: () => context.pop(),
          //   style: ElevatedButton.styleFrom(
          //     shape: const CircleBorder(),
          //     padding: EdgeInsets.all(deviceInfo.screenWidth * 0.02),
          //     backgroundColor: ColorsManager.lightGreyColor,
          //     shadowColor: Colors.transparent,
          //   ),
          // ),
        ],
      ),
    );
  }
}
