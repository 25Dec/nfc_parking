import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/routes/app_route_constants.dart';
import '../../../../core/utils/core_utils.dart';
import '../bloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    bool isEmailValid = CoreUtils.validateEmail(value!);
    return isEmailValid ? null : "Incorrect Email";
  }

  String? passwordValidator(String? value) {
    bool isPasswordValid = CoreUtils.validatePassword(value!);
    return isPasswordValid ? null : "Incorrect Password";
  }

  void signIn() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInWithEmailPasswordEvent(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is SignedInSuccessfullyState) {
            GoRouter.of(context).pushReplacementNamed(
              AppPage.nfcCardsShell.toName,
            );
          } else if (authState is UserDataExistsState) {
            GoRouter.of(context).pushReplacementNamed(
              AppPage.nfcCardsShell.toName,
            );
          } else if (authState is AuthErrorState) {
            CoreUtils.showCustomDialog(
              context,
              title: "Sign In Failed!",
              content: "Email or password is incorrect. Please try again.",
              confirmText: "Confirm",
            );
          }
        },
        builder: (context, authState) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/welcome.gif",
                      width: 300,
                      height: 300,
                    ),
                    const Text(
                      "NFC Convenient Parking App For Small Areas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black2,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      hintText: "Email",
                      validator: emailValidator,
                      prefixIcon: FluentIcons.mail_24_regular,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      hintText: "Password",
                      validator: passwordValidator,
                      prefixIcon: FluentIcons.password_24_regular,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: deviceWidth - 32,
                      child: ElevatedButton(
                        onPressed: signIn,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(AppColors.green),
                          foregroundColor: MaterialStateProperty.all(AppColors.white2),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
