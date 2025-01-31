import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/authentication/presentation/example_screen/logic/password_visiblity_bloc.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;

  const CustomTextField({super.key, required this.label, required this.hintText, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          //Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, isHidden) {
              return TextField(
                obscureText: isPassword ? isHidden : false, 
                decoration: InputDecoration(
                  label: Text("$label", style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w500)),
                  hintText: hintText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  suffixIcon: isPassword
                      ? IconButton(
                    icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => context.read<PasswordVisibilityCubit>().toggleVisibility(),
                  )
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
