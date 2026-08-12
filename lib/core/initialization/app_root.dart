import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partfolio_app/core/routing/routing.dart';
import 'package:partfolio_app/feautures/auth/presentation/state/auth_controller.dart';
import 'package:provider/provider.dart';
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
  late final AuthenticationRepository authRepo;
  // late final AppRouter appRouter;

  @override
  void didChangeDependencies() {
    // TODO: implement didUpdateWidget
    authRepo = DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository;
    // appRouter = AppRouter(authRepository: authRepo);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Mb authRepo not need manage stream lifecycle and will better to move User-logic to Some state class with ChangeNotifier like TasksStateModel
    authRepo.closeUserStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(authRepository: authRepo),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppRouter(authController: context.read<AuthController>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = Provider.of<AppRouter>(context);
          return MaterialApp.router(
            title: 'Flutter Demo',
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeDataLight,
            routerConfig: appRouter.goRoute,
          );
        },
      ),
    );
  }
}
