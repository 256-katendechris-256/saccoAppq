import 'package:get_it/get_it.dart';
import 'package:sacco/main_layout.dart';
import 'package:sacco/screens/auth_page.dart';
import 'package:sacco/screens/home_page.dart';
import 'package:sacco/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Service_Auth/service_file.dart';
import 'components/login.dart';
import 'components/register.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<Authentication_service>(
    Authentication_service(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primsryColor,
            border: Config.OutlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.OutlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primsryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primsryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          )),
      initialRoute: 'auth',
      routes: {
        // initial route for the app which is the login page and the signup page
        'auth': (context) => const AuthPage(),
        'home': (context) => const HomePage(),
        'login': (context) => const Login(),
        'register': (context) => const  RegisterPage (),
        // main layout after login page
        'main': (context) => const MainLayout(),
      },



    );
  }
}