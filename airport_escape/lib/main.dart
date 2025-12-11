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
            AndroidFlutterLocalNotificationsPlugin>()
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

  // Listen for token updates (best practice)
  FirebaseMessaging.instance.onTokenRefresh.listen((token) {
    print("FCM Token (refreshed): $token");
  });

  // iOS: Wait until APNS is ready before calling getToken()
  Future(() async {
    String? apns = await FirebaseMessaging.instance.getAPNSToken();

    if (apns == null) {
      print("APNS token not ready yet — waiting…");
      return;
    }

    final fcm = await FirebaseMessaging.instance.getToken();
    print("FCM Token (via APNS readiness): $fcm");
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
// LOGIN PAGE — NEW GRADIENT DESIGN
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
    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pw.text.trim(),
      );
      // AuthGate listens to authStateChanges, so no manual navigation needed.
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
        });
      }
    }
  }

  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void _goToForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordPage(),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _pw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    const double maxCardWidth = 420;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0f172a),
              Color(0xFF1d4ed8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxCardWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.flight_takeoff,
                    size: 72,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Airport Escape',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: loc.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _pw,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: loc.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (_error != null) ...[
                            Text(
                              _error!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _busy ? null : _signIn,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _busy
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      loc.signIn,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: _busy ? null : _goToForgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                          const SizedBox(height: 4),
                          TextButton(
                            onPressed: _goToRegister,
                            child: const Text(
                              "Don’t have an account? Sign up",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// REGISTER PAGE — Create Account
// ---------------------------------------------------------------
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Please fill in both fields.';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // AuthGate will react to auth change; just pop back to login/shell.
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Registration failed.';
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Something went wrong. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double maxCardWidth = 420;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxCardWidth),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_errorMessage != null) ...[
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleRegister,
                        child: _isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Create Account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// FORGOT PASSWORD PAGE — matches login look/feel
// ---------------------------------------------------------------
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _message;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _message = 'Please enter your email.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _message = 'Password reset email sent. Check your inbox.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = 'Could not send reset email: ${e.message}';
      });
    } catch (_) {
      setState(() {
        _message = 'Something went wrong. Try again later.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double maxCardWidth = 420;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0f172a),
              Color(0xFF1d4ed8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxCardWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.flight_takeoff,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Airport Escape',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Reset your password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the email associated with your account and we\'ll send you a reset link.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (_message != null) ...[
                            Text(
                              _message!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _message!.startsWith('Password reset')
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _sendResetEmail,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Send reset link'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Back to login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
