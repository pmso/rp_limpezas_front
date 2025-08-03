import 'package:flutter/material.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';
import 'package:rp_limpezas_front/service/apiService.dart';
import 'package:rp_limpezas_front/service/storageService.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  void login(BuildContext context, TextEditingController usernameController, TextEditingController passwordController) async{
    String username = usernameController.text;
    String password = passwordController.text;
    print('Login button pressed test $username $password');

    print('{"username_email":"$username","password":"$password"}');

    Apiservice.postData('auth/login','{"username_email":"$username","password":"$password"}').then((value) {
      String accessToken;
      String refreshToken;
      String user_id;
      String user_email;
      String username;
      String user_name;

    accessToken = value['accessToken'];
    refreshToken = value['refreshToken'];

    user_id = value['user']['id'];
    user_email = value['user']['email'];
    username = value['user']['username'];
    user_name = value['user']['name'] ?? '';

    StorageService.saveAccessToken(accessToken);
    StorageService.saveRefreshToken(refreshToken);

    StorageService.setGenericValue(StorageKeysEnum.userId.key, user_id);
    StorageService.setGenericValue(StorageKeysEnum.userEmail.key, user_email);
    StorageService.setGenericValue(StorageKeysEnum.userUsername.key, username);
    StorageService.setGenericValue(StorageKeysEnum.userName.key, user_name);

    Navigator.pushReplacementNamed(context, '/home');

  }).catchError((error) async {
    print('Erro ao obter token: $error');
    await StorageService.deleteTokens();
  });
  }

  @override
  Widget build(BuildContext context) {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    login(context,usernameController,passwordController); // Call the login function here
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
