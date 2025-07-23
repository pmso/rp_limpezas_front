import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/pages/home.dart';
import 'package:rp_limpezas_front/pages/welcome.dart';
import 'package:rp_limpezas_front/service/apiService.dart';
import 'package:rp_limpezas_front/service/tokenService.dart';
import 'package:rp_limpezas_front/pages/login.dart';

var token;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //TokenService.saveRefreshToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InBtYXNvIiwiZW1haWwiOiIxMjNAMWEyMy5jb20iLCJpZCI6IjIiLCJpYXQiOjE3NTI5NjAyNTAsImV4cCI6MTc1MzU2NTA1MH0.76CH_eF4A1zNKt--FkLsOfTCSYbl9xktgDuHrVv0b7o');
  final refreshToken = await TokenService.getRefreshToken();
  //print('Testando token: $refreshToken');
  Apiservice.postData('auth/token','{"refreshToken": "$refreshToken"}').then((value) {
    token = value['accessToken'];
    //print('Access Token: $token');
  }).catchError((error) async {
    //print('Erro ao obter token: $error');
    token = null; // Set token to null if there's an error
    await TokenService.deleteTokens();
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: Replace with persistent storage check for first time
    // Set to true to simulate first launch, or implement logic to check persistent storage
    bool firstTime = false;

    Widget initialWidget;
    if (firstTime) {
      initialWidget = const WelcomePage();
    } else {
      if (token == null) {
        initialWidget = const LoginPage();
      } else {
        initialWidget = const HomePage();
      }
    }

    return MaterialApp(
      home: initialWidget,
      debugShowCheckedModeBanner: false,
      title: 'RP Limpezas',
    );
  }
}
