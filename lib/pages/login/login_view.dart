// login page

import 'package:flutter/material.dart';
import 'package:surgetv/dao/user_dao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login() {
    UserDao.login().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.loginRegister),
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
