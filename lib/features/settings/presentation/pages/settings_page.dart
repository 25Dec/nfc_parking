import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_elevated_button_with_icon.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/routes/app_route_constants.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.green,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    BlocProvider.of<AuthBloc>(context).add(
      GetUserDataEvent(),
    );
  }

  void signOut() {
    GoRouter.of(context).goNamed(AppPage.signIn.toName);
    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
  }

  void editProfile() {}

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          String fullName = "";
          String phoneNumber = "";
          String email = "";

          if (authState is UserDataExistsState) {
            final user = authState.userData;
            fullName = user.fullName;
            email = user.email;
            phoneNumber = user.phoneNumber;
          }

          return SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: Stack(
              children: [
                Container(
                  width: deviceWidth,
                  height: deviceHeight * 0.5,
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 8,
                    left: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: AppColors.white2,
                        backgroundImage: AssetImage("assets/images/boss_avatar.png"),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        fullName,
                        style: const TextStyle(
                          color: AppColors.white2,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: deviceHeight * 0.35,
                  child: Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.26,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      color: AppColors.white2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomElevatedButtonWithIcon(
                                    icon: FluentIcons.edit_24_regular,
                                    text: "Edit",
                                    onPressed: editProfile,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomElevatedButtonWithIcon(
                                    icon: FluentIcons.sign_out_24_regular,
                                    text: "Sign Out",
                                    onPressed: signOut,
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Email:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(
                                      fontSize: 16, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Phone Number:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
