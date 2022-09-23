import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_parking/pages/home_screen.dart';
import 'package:rate_my_parking/pages/licence_screen.dart';
import 'package:rate_my_parking/pages/login_screen.dart';
import 'package:rate_my_parking/pages/post_detail.dart';
import 'package:rate_my_parking/pages/signup_screen.dart';

import 'helpers/view_utils.dart';
import 'pages/add_post_screen.dart';

void main()  {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }
  void initialization() async {
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rate My Parking',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue[50],
        ),
          primarySwatch: Colors.blue, textTheme: GoogleFonts.latoTextTheme(),),
      initialRoute: ViewUtils.licenceNumberRoute,
      routes: {
        // ViewUtils.splashRoute: (context) => const SplashPage(),
        ViewUtils.licenceNumberRoute: (context) => const LicenceScreenPage(),
        ViewUtils.homeRoute: (context) => const HomeScreen(),
        ViewUtils.postDetailRoute: (context) => const DetailScreen(),
        ViewUtils.loginRoute: (context) => const LoginScreenPage(),
        ViewUtils.signUpRoute: (context) => const SignUpScreenPage(),
        ViewUtils.addPostRoute: (context) => const AddPostScreenPage(),
      },
    );
  }
}

