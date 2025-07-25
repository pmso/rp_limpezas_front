import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';
import 'package:rp_limpezas_front/service/apiService.dart';
import 'package:rp_limpezas_front/service/storageService.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  var token;
var firstString;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    startApp();
  }

  void startApp() async{
  final wait2Seconds = Future.delayed(const Duration(seconds: 2));  
    //TokenService.saveRefreshToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InBtYXNvIiwiZW1haWwiOiIxMjNAMWEyMy5jb20iLCJpZCI6IjIiLCJpYXQiOjE3NTI5NjAyNTAsImV4cCI6MTc1MzU2NTA1MH0.76CH_eF4A1zNKt--FkLsOfTCSYbl9xktgDuHrVv0b7o');
  final refreshToken = await StorageService.getRefreshToken();
  firstString= await StorageService.getGenericValue(StorageKeysEnum.firstTime.key);
  //print('Testando token: $refreshToken');
  Apiservice.postData('auth/token','{"refreshToken": "$refreshToken"}').then((value) {
    token = value['accessToken'];
    print('Access Token: $token');
    StorageService.saveAccessToken(token);
  }).catchError((error) async {
    print('Erro ao obter token: $error');
    token = null; // Set token to null if there's an error
    await StorageService.deleteTokens();
  });

    await Future.wait([wait2Seconds]); // Wait for both


  bool firstTime = firstString!='false';
    print(firstString);
    if (firstTime) {
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      if (token == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: SweepGradient(
                startAngle: 0.0,
                endAngle: 2 * math.pi,
                colors: [
                  Colors.blue,
                  Colors.green,
                  Colors.blue,
                ],
                transform: GradientRotation(_controller.value * 2 * math.pi),
              ),
            ),
            child: Center(
  child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/adaptive-icon.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 12),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'RP',
                style: TextStyle(color: Colors.green),
              ),
              TextSpan(
                text: ' Limpezas',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
          );
        },
      ),
    );
  }
}