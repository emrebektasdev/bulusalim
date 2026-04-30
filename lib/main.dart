import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/firebase/analytics_service.dart';
import 'core/firebase/app_logger.dart';
import 'core/firebase/crashlytics_service.dart';
import 'core/firebase/fcm_service.dart';
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _log = AppLogger.getLogger('main');


  // 1. Logger
  AppLogger.init();

  // 2. Firebase Core
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Crashlytics (must be before runApp so errors in init are captured)
  await CrashlyticsService.init();

  // 4. Analytics
  await AnalyticsService.init();

  try {
    // 5. Google Sign-In
    _log.info('Initialising Google Sign-In...');
    await GoogleSignIn.instance.initialize();
    _log.info('Google Sign-In initialised');

    // 6. FCM + local notifications
    _log.info('Initialising FCM...');
    await FcmService.init();
    _log.info('FCM initialised');
  } catch (e, st) {
    _log.severe('Startup initialization failed at step 5 or 6', e, st);
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Buluşalım',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
