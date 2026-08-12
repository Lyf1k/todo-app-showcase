import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/initialization/app_root.dart';
import 'core/initialization/models/dependencies_container.dart';
import 'core/initialization/widgets/dependencies_scope.dart';
import 'core/service/notification_service.dart';
import 'feautures/auth/data/data_source/local_auth_datasource_impl.dart';
import 'feautures/auth/data/mapper/user_mapper.dart';
import 'feautures/auth/data/repository/authentication_repository_impl.dart';
import 'feautures/tasks/data/datasource/local_tasks_data_source_impl.dart';
import 'feautures/tasks/data/mapper/tasks_mapper.dart';
import 'feautures/tasks/data/repository/local_tasks_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = SharedPreferencesAsync();

  tz.initializeTimeZones();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final WindowsInitializationSettings initializationSettingsWindows =
      WindowsInitializationSettings(
        appName: 'Flutter Local Notifications Example',
        appUserModelId: 'Com.Dexterous.FlutterLocalNotificationsExample',
        // Search online for GUID generators to make your own
        guid: 'd49b0314-ee7a-4626-bf79-97cdb8a991bb',
      );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
    windows: initializationSettingsWindows,
  );
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
  );

  final androidPlugin = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  if (androidPlugin != null) {
    await androidPlugin.requestExactAlarmsPermission();
    await androidPlugin.requestNotificationsPermission();
    await androidPlugin.requestNotificationPolicyAccess();
  }
  // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()?..requestNotificationsPermission()..requestNotificationPolicyAccess();

  // Add: Dependencies container
  runApp(
    DependenciesScope(
      dependencies: DependenciesContainer(
        notificationService: NotificationService(
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        ),
        tasksRepository: TasksRepositoryImpl(
          dataSource: LocalTasksDataSourceImpl(
            sharedPreferences: sharedPreferences,
          ),
          tasksMapper: TasksMapper(),
        ),
        sharedPreferencesAsync: sharedPreferences,
        authenticationRepository: AuthenticationRepositoryImpl(
          dataSource: LocalAuthDatasourceImpl(
            sharedPreferences: sharedPreferences,
          ),
          mapper: UserMapper(),
        ),
      ),
      child: AppRoot(),
    ),
  );
}
