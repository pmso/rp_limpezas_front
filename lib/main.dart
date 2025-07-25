import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';
import 'package:rp_limpezas_front/pages/home.dart';
import 'package:rp_limpezas_front/pages/signup.dart';
import 'package:rp_limpezas_front/pages/splash.dart';
import 'package:rp_limpezas_front/pages/welcome.dart';
import 'package:rp_limpezas_front/service/apiService.dart';
import 'package:rp_limpezas_front/service/storageService.dart';
import 'package:rp_limpezas_front/pages/login.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    

/*     return MaterialApp(
      home: initialWidget,
      debugShowCheckedModeBanner: false,
      title: 'RP Limpezas'
    ); */

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RP Limpezas',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
