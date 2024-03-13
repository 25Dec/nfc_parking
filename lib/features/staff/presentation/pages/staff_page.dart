import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/common/widgets/custom_text_button.dart';
import '../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/routes/app_route_constants.dart';
import '../../../../core/utils/core_utils.dart';
import '../bloc/staff_bloc.dart';
import '../widgets/slidable_staff_card.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  void initState() {
    super.initState();
    getAllStaff();
  }

  Future<void> getAllStaff() async {
    BlocProvider.of<StaffBloc>(context).add(
      GetAllStaffEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<StaffUserEntity> staff = [];

    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, staffState) {
        if (staffState is DoneGettingAllStaffState) {
          staff = staffState.staff;
        }

        if (staffState is StaffErrorState) {
          CoreUtils.showCustomDialog(
            context,
            title: "Account Create Failed!",
            content: staffState.message,
            confirmText: "Confirm",
          );
        }

        return RefreshIndicator(
          onRefresh: getAllStaff,
          child: Scaffold(
            appBar: CustomTopAppBar(
              routeName: AppPage.staff.toName,
              totalNumberOfStaff: staff.length,
            ),
            body: staff.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: staff.length,
                      itemBuilder: (_, index) => SlidableStaffCard(
                        data: staff[index],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset(
                            "assets/images/empty_bird.jpg",
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "There Are No Staff Yet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextButton(
                          onPressed: () => GoRouter.of(context)
                              .pushNamed(AppPage.signUpStaffAccount.toName),
                          text: "Click here to add a new staff",
                          textColor: AppColors.green,
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
