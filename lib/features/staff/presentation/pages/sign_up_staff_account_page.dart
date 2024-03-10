import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_parking/core/common/widgets/custom_text_form_field.dart';
import 'package:nfc_parking/core/res/app_colors.dart';
import 'package:nfc_parking/core/utils/core_utils.dart';
import 'package:nfc_parking/features/staff/presentation/bloc/staff_bloc.dart';

import '../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../core/routes/app_route_constants.dart';

class SignUpStaffAccountPage extends StatefulWidget {
  const SignUpStaffAccountPage({super.key});

  @override
  State<SignUpStaffAccountPage> createState() => _SignUpStaffAccountPageState();
}

class _SignUpStaffAccountPageState extends State<SignUpStaffAccountPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? phoneNumberValidator(String? value) {
    bool isPhoneNumberValid = CoreUtils.validatePhoneNumber(value!);
    return isPhoneNumberValid ? null : "Số điện thoại không hợp lệ";
  }

  String? passwordValidator(String? value) {
    bool isPasswordValid = CoreUtils.validatePassword(value!);
    return isPasswordValid ? null : "Mật khẩu không hợp lệ";
  }

  String? confirmPasswordValidator(String? value) {
    return confirmPasswordController.text == passwordController.text
        ? null
        : "Mật khẩu không khớp";
  }

  void signUpStaffAccount() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<StaffBloc>(context).add(
        SignUpStaffAccountEvent(
          fullName: fullNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomTopAppBar(
        routeName: AppPage.signUpStaffAccount.toName,
      ),
      body: BlocConsumer<StaffBloc, StaffState>(
        listener: (context, staffState) {
          if (staffState is SignUpStaffAccountSuccessfully) {
            CoreUtils.showCustomDialog(
              context,
              title: "Account Created Successfully!",
              content:
                  "Account for ${fullNameController.text} has been created successfully.",
              confirmText: "Confirm",
              onConfirm: () => GoRouter.of(context).pop(),
            );
          } else if (staffState is StaffErrorState) {
            CoreUtils.showCustomDialog(
              context,
              title: "Tạo tài khoản thất bại!",
              content: "Vui lòng thử lại sau",
              confirmText: "Confirm",
            );
          }
        },
        builder: (context, staffState) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "Fullname",
                      prefixIcon: FluentIcons.person_circle_24_regular,
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: "Email",
                      prefixIcon: FluentIcons.mail_24_regular,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: "Phone Number",
                      prefixIcon: FluentIcons.call_24_regular,
                      controller: phoneNumberController,
                      validator: phoneNumberValidator,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: "Password",
                      prefixIcon: FluentIcons.password_24_regular,
                      controller: passwordController,
                      validator: passwordValidator,
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: "Confirm Password",
                      prefixIcon: FluentIcons.password_24_regular,
                      controller: confirmPasswordController,
                      validator: confirmPasswordValidator,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: deviceWidth - 32,
                      child: ElevatedButton(
                        onPressed: signUpStaffAccount,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(AppColors.green),
                          foregroundColor: MaterialStateProperty.all(AppColors.white2),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
