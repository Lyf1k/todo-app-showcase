import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/initialization/widgets/dependencies_scope.dart';
import '../../../../core/theme/app_colors.dart';
import '../state/auth_controller.dart';
import '../utils/auth_form_field.dart';
import '../utils/snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController nameController;
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    loginController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    nameController.dispose();
    loginController.clear();
    loginController.dispose();
    passwordController.clear();
    passwordController.dispose();
    confirmPasswordController.clear();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context)!.dependencies;
    final authController = Provider.of<AuthController>(context);
    final heigh = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: heigh * 0.001,
              left: heigh * 0.002,
              child: IconButton(
                onPressed: () {
                  context.goNamed('login');
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/Component 1.svg'),
            ),
            Positioned.fill(
              top: MediaQuery.sizeOf(context).height * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black),
                    BoxShadow(color: Colors.green),
                    BoxShadow(color: Colors.blueGrey),
                    BoxShadow(color: Colors.grey),
                  ],
                  // color: AppColors.onPrimary,
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                height: heigh * 0.2,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: heigh * 0.04,
                    left: heigh * 0.016,
                    right: heigh * 0.016,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Registration',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        AuthTextField(
                          validator: (value) {
                            if (value!.length <= 3) {
                              return "Name length must be more 3 characters";
                            } else if (value.isEmpty) {
                              return "Name can\'t be empty";
                            }
                            return null;
                          },
                          controller: nameController,
                          hintText: "Name ...",
                          titleText: "Name",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        AuthTextField(
                          controller: loginController,
                          hintText: "Login ...",
                          titleText: "Login",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        AuthTextField(
                          validator: (value) {
                            if (value!.length <= 7) {
                              return "Password length must be more 4 characters";
                            } else if (value.isEmpty) {
                              return "Passowrd can\'t be empty";
                            }
                            return null;
                          },
                          isPassword: true,
                          controller: passwordController,
                          hintText: "Password",
                          titleText: "Password",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        AuthTextField(
                          validator: (value) {
                            if (value == null) {
                              return "Confim password can'\t be empty";
                            }
                            if (value != confirmPasswordController.text) {
                              return "Password don\'t match";
                            } else if (value!.isEmpty) {
                              return "Confirm password don\'t match and is empty";
                            }
                            return null;
                          },
                          isPassword: true,
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          titleText: "Confirm Password",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == false) {
                                print("Button pressed");
                                return;
                              } else {
                                try {
                                  print("Init register");
                                  await authController.registration(
                                    login: loginController.text,
                                    name: nameController.text,
                                    password: passwordController.text,
                                  );
                                  context.goNamed('login');
                                } catch (e) {
                                  showSnackBar(
                                    label: '$e',
                                    context: context,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                    contentTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: AppColors.onError),
                                  );
                                  print("Some error: $e");
                                }
                              }
                            },
                            child: Text("Register"),
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
