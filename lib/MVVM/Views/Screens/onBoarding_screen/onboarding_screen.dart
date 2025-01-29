import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/MVVM/Views/Screens/onBoarding_screen/widgets/on_board_model.dart';

import '../../../View_Models/onBoarding_cubit/on_boarding_cubit.dart';
import 'on_board_content.dart';
import 'widgets/page_indicator.dart';
import '../auth_screens/widgets/bottom_buttons.dart';
import '../../../../theming/colors.dart';
import 'package:social_media/Responsive/ui_component/info_widget.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  final List<OnboardModel> pages = [
    OnboardModel(
      image: "assets/images/onboarding_firstScreen.png",
      title: "Find Friends & Get Inspiration",
      description: "",
    ),
    OnboardModel(
      image: "assets/images/onboarding_secondScreen.png",
      title: "Meet Awesome People & Enjoy Yourself",
      description: "",
    ),
    OnboardModel(
      image: "assets/images/onboarding_thirdScreen.png",
      title: "Hangout with Friends",
      description: "",
    ),
  ];

  void _nextPage(BuildContext context) {
    final currentIndex = context.read<OnboardingCubit>().state;
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      context.read<OnboardingCubit>().updatePage(currentIndex + 1);
    } else {
      // Navigate to another screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: InfoWidget(builder: (context, info) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: ColorsManager.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: BlocBuilder<OnboardingCubit, int>(
                    builder: (context, currentPage) {
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) =>
                            context.read<OnboardingCubit>().updatePage(index),
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          return OnboardContent(page: pages[index]);
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<OnboardingCubit, int>(
                  builder: (context, currentPage) {
                    return PageIndicator(currentPage: currentPage, pageCount: pages.length);
                  },
                ),
                const SizedBox(height: 30),
                BottomButtons(onNext: () => _nextPage(context)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}
