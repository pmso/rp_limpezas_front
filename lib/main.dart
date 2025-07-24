import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';
import 'package:rp_limpezas_front/pages/home.dart';
import 'package:rp_limpezas_front/pages/splash.dart';
import 'package:rp_limpezas_front/pages/welcome.dart';
import 'package:rp_limpezas_front/service/apiService.dart';
import 'package:rp_limpezas_front/service/storageService.dart';
import 'package:rp_limpezas_front/pages/login.dart';

var token;
var firstString;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //TokenService.saveRefreshToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InBtYXNvIiwiZW1haWwiOiIxMjNAMWEyMy5jb20iLCJpZCI6IjIiLCJpYXQiOjE3NTI5NjAyNTAsImV4cCI6MTc1MzU2NTA1MH0.76CH_eF4A1zNKt--FkLsOfTCSYbl9xktgDuHrVv0b7o');
  final refreshToken = await StorageService.getRefreshToken();
  firstString= await StorageService.getGenericValue(StorageKeysEnum.firstTime.key);
  //print('Testando token: $refreshToken');
  Apiservice.postData('auth/token','{"refreshToken": "$refreshToken"}').then((value) {
    token = value['accessToken'];
    //print('Access Token: $token');
  }).catchError((error) async {
    print('Erro ao obter token: $error');
    token = null; // Set token to null if there's an error
    await StorageService.deleteTokens();
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    bool firstTime = firstString!='false';
    print(firstString);
    Widget initialWidget;
    if (firstTime) {
      initialWidget = const WelcomePage();
    } else {
      if (token == null) {
        initialWidget = const SplashScreen();//LoginPage();
      } else {
        initialWidget = const HomePage();
      }
    }

    return MaterialApp(
      home: initialWidget,
      debugShowCheckedModeBanner: false,
      title: 'RP Limpezas'
    );
  }
}
