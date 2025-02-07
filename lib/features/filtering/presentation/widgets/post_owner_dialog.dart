import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtered_users/filtered_users_cubit.dart';

class PostOwnerDialog extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController parentController;
  final TextEditingController dialogController;
  final BuildContext context;
  final FilteredUsersCubit filteredUsersCubit;
  const PostOwnerDialog(
      {super.key,
      required this.width,
      required this.height,
      required this.parentController,
      required this.context,
      required this.filteredUsersCubit,
      required this.dialogController});

  @override
  State<PostOwnerDialog> createState() => _PostOwnerDialogState();
}

class _PostOwnerDialogState extends State<PostOwnerDialog> {
  Timer? debounceTimer;
  @override
  void dispose() {
    debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.filteredUsersCubit,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            TextField(
              controller: widget.dialogController,
              decoration:
                  formInputStyle(label: 'Post Owner', hintText: 'Enter a name'),
              onChanged: (value) {
                debounceTimer?.cancel();
                debounceTimer = Timer(const Duration(seconds: 1), () {
                  widget.dialogController.text = value;
                  widget.filteredUsersCubit.loadFilteredUsers(
                      queryParameters: {'fullName': value},
                      token: context.read<userMainDetailsCubit>().state.token!);
                });
              },
            ),
            BlocBuilder<FilteredUsersCubit, FilteredUsersState>(
              builder: (context, state) {
                if (state is FilteredUsersLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: false,
                      padding: EdgeInsets.all(8),
                      itemCount: state.filteredUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.filteredUsers[index].fullName),
                          onTap: () {
                            widget.dialogController.text =
                                state.filteredUsers[index].fullName;
                            widget.parentController.text =
                                state.filteredUsers[index].id.toString();
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                } else if (state is FilteredUsersLoading) {
                  return const CircularProgressIndicator();
                } else if (state is FilteredUsersError) {
                  return Center(
                    child: Text('an error occurred '),
                  );
                } else {
                  return Center(
                    child: Text('enter a name'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
