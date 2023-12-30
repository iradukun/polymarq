import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polymarq/amplifyconfiguration.dart';
import 'package:polymarq/authentication/view/screens/bottom_nav_bar.dart';
import 'package:polymarq/authentication/view/screens/onboarding_screen.dart';
import 'package:polymarq/firebase_options.dart';
import 'package:polymarq/providers/constants.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/services/notification/notification_service.dart';
import 'package:polymarq/utils/color.dart';

NotificationsController notificationController = NotificationsController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await _configureAmplify();
    await _configureFirebase();
  } on AmplifyAlreadyConfiguredException {
    debugPrint('Amplify configuration failed.');
  }
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<dynamic>(StorageConstant.BOX_NAME);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polymarq',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColor.white,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: AppColor.white),
      ),
      navigatorKey: AppRoute.navigatorKey,
      onGenerateRoute: AppRoute.generateRoute,
      home: MyPref.user != null
          ? const BottomNavBarScreen()
          : const OnboardingScreen(),
    );
  }
}

Future<void> _configureAmplify() async {
  final authPlugin = AmplifyAuthCognito();
  final pushPlugin = AmplifyPushNotificationsPinpoint();
  // final analyticsPlugin = AmplifyAnalyticsPinpoint();
  await Amplify.addPlugins([
    authPlugin,
    pushPlugin,
    // analyticsPlugin,
  ]);
  await Amplify.configure(amplifyconfig);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  notificationController = NotificationsController();
  await notificationController.messageHandler(message);
}

Future<void> _configureFirebase() async {
  await Firebase.initializeApp();
  await notificationController.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
