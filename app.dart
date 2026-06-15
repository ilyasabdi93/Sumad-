import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/theme/theme_manager.dart';
import 'core/config/app_config.dart';
import 'core/di/providers.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/splash/splash_screen.dart';

class SumadApp extends ConsumerStatefulWidget {
  const SumadApp({super.key});

  @override
  ConsumerState<SumadApp> createState() => _SumadAppState();
}

class _SumadAppState extends ConsumerState<SumadApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupFirebaseMessaging();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        ref.read(fcmTokenProvider.notifier).state = token;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show local notification
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Navigate to specific content
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = context.locale;

    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: SumadTheme.lightTheme,
      darkTheme: SumadTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}