import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/auth_screens/auth_screen.dart';
import 'package:social_media/theming/colors.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onNext;

  const BottomButtons({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Join Now",
                  style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to Login
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()
                  ));
                },
                child:  Text(
                  "Sign In",
                  style: TextStyle(

                    fontSize: 16,
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            ),
        );
    }}
