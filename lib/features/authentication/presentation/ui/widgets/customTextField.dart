import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/features/authentication/presentation/logic/password_visiblity_bloc.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;

  const CustomTextField({super.key, required this.label, required this.hintText, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(), 
      child: InfoWidget(builder: (context, info) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BlocBuilder<PasswordVisibilityCubit, bool>(
              builder: (context, isHidden) {
                return TextField(
                  obscureText: isPassword ? isHidden : false,
                  decoration: InputDecoration(
                    label: Text(label, style: TextStyle(color: Colors.grey[800],fontSize: info.screenWidth * 0.035, fontWeight: FontWeight.w500)),
                    hintText: hintText,
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: info.screenWidth * 0.001), borderRadius: BorderRadius.circular(info.screenWidth * 0.04)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: info.screenWidth * 0.001), borderRadius: BorderRadius.circular(info.screenWidth * 0.04)),

                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsManager.primaryColor, width: info.screenWidth * 0.003), borderRadius: BorderRadius.circular(info.screenWidth * 0.04)),
                    filled: true,
                    fillColor: Colors.grey.shade100,

                    suffixIcon: isPassword
                        ? IconButton(
                      icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => context.read<PasswordVisibilityCubit>().toggleVisibility(),
                    )
                        : null,
                  ),
                  textInputAction: TextInputAction.next,
                );  
              },
            ),
          ],
        );
      }),
    );
  }
}
