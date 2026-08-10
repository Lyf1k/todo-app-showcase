import 'package:flutter/material.dart';

import '../../feautures/auth/domain/repository/authentication_repository.dart';
import '../theme/app_theme.dart';
import 'auth_gate.dart';
import 'widgets/dependencies_scope.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {

  AuthenticationRepository? authRepo;

  @override
  void didUpdateWidget(covariant AppRoot oldWidget) {
    // TODO: implement didUpdateWidget
    authRepo ??= DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository;
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    // Mb authRepo not need manage stream lifecycle and will better to move User-logic to Some state class with ChangeNotifier like TasksStateModel
    authRepo?.closeUserStream();

    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeDataLight,
      home: AuthGate(checkUser: () { 
        DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository.getCurrentUser();
       },),
    );
  }
}
