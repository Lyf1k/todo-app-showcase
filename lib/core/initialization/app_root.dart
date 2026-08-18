import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/auth/domain/repository/authentication_repository.dart';
import '../../features/auth/presentation/state/auth_controller.dart';
import '../routing/routing.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
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
    final dependencies = DependenciesScope.of(context)!.dependencies;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(authRepository: authRepo),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              AppRouter(authController: context.read<AuthController>()),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeController(
            sharedPreferencesAsync: dependencies.sharedPreferencesAsync,
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = Provider.of<AppRouter>(context);
          // final themeMode = Provider.of<AppThemeController>(context);
          return Consumer<AppThemeController>(
            builder: (context, state, child) => MaterialApp.router(
              title: 'Flutter Demo',
              // themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              theme: state.isDark
                  ? AppTheme.themeDataDark
                  : AppTheme.themeDataLight,
              routerConfig: appRouter.goRoute,
            ),
          );
        },
      ),
    );
  }
}
