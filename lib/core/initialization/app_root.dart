import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'auth_gate.dart';
import 'widgets/dependencies_scope.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void dispose() {
    // Mb authRepo not need manage stream lifecycle and will better to move User-logic to Some state class with ChangeNotifier like TasksStateModel
    DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository.closeUserStream();

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
      home: AuthGate(),
    );
  }
}
