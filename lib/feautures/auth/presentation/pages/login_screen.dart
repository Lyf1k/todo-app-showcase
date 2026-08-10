import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partfolio_app/core/initialization/widgets/dependencies_scope.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../tasks/presentation/bottom_navigation_bar.dart';
import '../../domain/repository/authentication_repository.dart';
import '../../utils/auth_validators.dart';
import '../utils/auth_form_field.dart';
import '../utils/snack_bar.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> key;

  @override
  void initState() {
    // TODO: implement initState
    loginController = TextEditingController();
    passwordController = TextEditingController();
    key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    // TODO: implement didUpdateWidget\
    key.currentState?.reset();
    key.currentState?.dispose();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    key.currentState?.reset();
    key.currentState?.dispose();
    loginController.clear();
    loginController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heigh = MediaQuery.sizeOf(context).height;
    return Scaffold(
      // backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: heigh * 0.015),
                child: SvgPicture.asset('assets/Component 1.svg'),
              ),
            ),
            Positioned.fill(
              top: heigh * 0.09,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: heigh * 0.04,
                    left: heigh * 0.016,
                    right: heigh * 0.016,
                  ),
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'Authorization',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                        ),
                        AuthTextField(
                          validator: (value) =>
                              validatorLogin(name: loginController.text),
                          controller: loginController,
                          hintText: "Login ...",
                          titleText: "Login",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        AuthTextField(
                          validator: (value) => validatorPassword(
                            password: passwordController.text,
                          ),
                          isPassword: true,
                          controller: passwordController,
                          hintText: "Password ...",
                          titleText: "Password",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final auth = DependenciesScope.of(
                                  context,
                                )!.dependencies.authenticationRepository;
                                if (key.currentState!.validate()) {
                                  await auth.login(
                                    login: loginController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  // print("Validate true");
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => HomeScreen(),
                                  //   ),
                                  // );
                                }
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                showSnackBar(label: '$e', context: context, backgroundColor: Theme.of(context).colorScheme.error, contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onError),);
                                print("Some error: $e");
                              }
                            },
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
                                        Shadow(
                                          blurRadius: 15,
                                          color: Colors.red,
                                        ),
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
                                    key.currentState!.reset();
                                    loginController.clear();
                                    passwordController.clear();
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
            ),
          ],
        ),
      ),
    );
  }
}
