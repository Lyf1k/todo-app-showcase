import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partfolio_app/core/theme/app_colors.dart';
import 'package:partfolio_app/feautures/auth/presentation/registration_screen.dart';
import 'package:partfolio_app/feautures/auth/utils/auth_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginController.clear();
    loginController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.3,
              child: SvgPicture.asset('assets/Component 1.svg'),
            ),
            Positioned.fill(
              top: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Authorization',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      AuthTextField(
                        controller: loginController,
                        hintText: "Login ...",
                        text: "Login",
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      AuthTextField(
                        isPassword: true,
                        controller: passwordController,
                        hintText: "Password",
                        text: "Password",
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Colors.blue,
                                    shadows: [
                                      Shadow(blurRadius: 15, color: Colors.red),
                                    ],
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Register
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          RegistrationScreen(),
                                    ),
                                  );
                                  print("Button tapped");
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
