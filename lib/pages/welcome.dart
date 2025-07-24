import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';
import 'package:rp_limpezas_front/pages/login.dart';
import 'package:rp_limpezas_front/service/storageService.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bem-vindo ao RP Limpezas!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Seu aplicativo para serviços de limpeza doméstica.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  StorageService.setGenericValue(StorageKeysEnum.firstTime.key, 'false');
                  // Navigate to the login page
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: const Text('Começar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}