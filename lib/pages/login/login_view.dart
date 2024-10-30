// login page

import 'package:flutter/material.dart';
import 'package:surgetv/dao/user_dao.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login() {
    UserDao.login().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('登录/注册'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen using a named route.
            // Navigator.pushNamed(context, '/home');
            _login();
          },
          child: const Text('登录'),
        ),
      ),
    );
  }
}
