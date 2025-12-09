// ---------------------------------------------------------------
// CLEAN MAIN.DART — AIRPORT ESCAPE
// ---------------------------------------------------------------

// Flutter / Firebase core
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

// Localization / Theme
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'settings/theme_toggle.dart';
import 'settings/locale_provider.dart';

// Pages
import 'landing_page.dart';
import 'set_timer_page.dart';
import 'database_test_page.dart';
import 'notification_test_page.dart';

// Notifications
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// ---------------------------------------------------------------
// APP COLORS
// ---------------------------------------------------------------
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

// ---------------------------------------------------------------
// NOTIFICATION SERVICE — CLEAN + CROSS-PLATFORM
// ---------------------------------------------------------------
class NotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    // Android
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(android: android, iOS: ios);

    await plugin.initialize(initSettings);

    // Android Channel
    const channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "Used for important notifications.",
      importance: Importance.high,
    );

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }
}

// ---------------------------------------------------------------
// BACKGROUND FCM HANDLER
// ---------------------------------------------------------------
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Background message received: ${message.messageId}');
}

// ---------------------------------------------------------------
// MAIN ENTRY POINT
// ---------------------------------------------------------------
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env (optional)
  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    debugPrint("No .env file found — skipping .env load");
  }

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background FCM handler
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // Local Notifications
  await NotificationService.initialize();

  // FCM Permissions
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print("FCM permission status: ${settings.authorizationStatus}");

  // DEBUG: Print token
  // final token = await messaging.getToken();
  // print("FCM Token: $token");

  // Show notifications while app is open
  FirebaseMessaging.onMessage.listen((msg) {
    NotificationService.plugin.show(
      msg.hashCode,
      msg.notification?.title,
      msg.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel",
          "High Importance Notifications",
          importance: Importance.high,
        ),
      ),
    );
  });
  FirebaseMessaging.instance.getInitialMessage();

  // Listen to token updates (works on iOS + Android)
  FirebaseMessaging.instance.onTokenRefresh.listen((token) {
    print("FCM Token (refreshed): $token");
  });

  // Try getting token only when it's available
  Future.delayed(const Duration(seconds: 1), () async {
    final token = await FirebaseMessaging.instance.getToken();
    print("FCM Token (when ready): $token");
  });

  // Run App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// ---------------------------------------------------------------
// ROOT WIDGET
// ---------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;

    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Airport Escape — for passengers by passengers',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kBackgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {'/set-timer': (_) => const SetTimerPage()},
          home: const _AuthGate(),
        );
      },
    );
  }
}

// ---------------------------------------------------------------
// AUTH GATE
// ---------------------------------------------------------------
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (!snap.hasData) return const _LoginPage();

        final user = snap.data!;
        return FutureBuilder<DataSnapshot>(
          future: FirebaseDatabase.instance
              .ref('roles/${user.uid}/isAdmin')
              .get(),
          builder: (context, roleSnap) {
            if (!roleSnap.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final isAdmin = roleSnap.data?.value == true;
            print("isAdmin for ${user.uid}: $isAdmin");

            return _Shell(isAdmin: isAdmin);
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------
// SHELL — WRAPS MAIN HOME
// ---------------------------------------------------------------
class _Shell extends StatelessWidget {
  final bool isAdmin;
  const _Shell({required this.isAdmin});

  Future<void> _saveAnnouncement() async {
    final u = FirebaseAuth.instance.currentUser;
    await FirebaseDatabase.instance.ref('content/announcements').update({
      'text': 'Hello from Airport Escape!',
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'updatedBy': u?.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyHomePage(),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: _saveAnnouncement,
              child: const Icon(Icons.save),
            )
          : null,
    );
  }
}

// ---------------------------------------------------------------
// LOGIN PAGE (unchanged from your version, only formatted slightly)
// ---------------------------------------------------------------
class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  final _email = TextEditingController();
  final _pw = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pw.text.trim(),
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.signIn)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(labelText: loc.email),
            ),
            TextField(
              controller: _pw,
              decoration: InputDecoration(labelText: loc.password),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _busy ? null : _signIn,
              child: Text(loc.signIn),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
