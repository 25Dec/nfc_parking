// ignore_for_file: use_build_context_synchronously

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/utils/core_utils.dart';
import '../bloc/staff_bloc.dart';

class SlidableStaffCard extends StatefulWidget {
  final StaffUserEntity data;

  const SlidableStaffCard({super.key, required this.data});

  @override
  State<SlidableStaffCard> createState() => _SlidableStaffCardState();
}

class _SlidableStaffCardState extends State<SlidableStaffCard> {
  void deleteStaffAccount(BuildContext context) async {
    bool? isConfirm = await CoreUtils.showCustomDialog(
      context,
      title: "Delete Staff Account?",
      content:
          "Are you sure want to delete this staff account? You can't undo this action.",
      dismissText: "Dismiss",
      confirmText: "Confirm",
      onConfirm: () {},
    );

    if (isConfirm!) {
      BlocProvider.of<StaffBloc>(context).add(
        DeleteStaffAccountEvent(staffID: widget.data.userID),
      );
    }
  }

  @override
  Widget build(BuildContext slidableStaffCardContext) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        key: ValueKey(widget.data),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteStaffAccount(slidableStaffCardContext),
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              icon: FluentIcons.delete_16_regular,
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white6,
                    backgroundImage: AssetImage("assets/images/staff_avatar.png"),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(FluentIcons.person_circle_24_regular),
                        const SizedBox(width: 8),
                        Text(
                          widget.data.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(FluentIcons.call_24_regular),
                        const SizedBox(width: 8),
                        Text(widget.data.phoneNumber),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(FluentIcons.people_24_regular),
                        const SizedBox(width: 8),
                        Text(
                          widget.data.role.name.substring(0, 1).toUpperCase() +
                              widget.data.role.name.substring(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
