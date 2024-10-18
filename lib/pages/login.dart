// login page

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:surgetv/dao/user_dao.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${accessToken.toJson()}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _login() {
    UserDao.login().then((value) {
      print(value);
    });
  }

  Future<void> _facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }

  void _getFacebookToken() async {
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      // user is logged
    }
  }

  void _getFacebookUser() async {
    final user = await FacebookAuth.instance.getUserData();
    print('_getFacebookUser $user');
  }

  Future<void> _facebookLogout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('登录/注册'),
      ),
      body: Column(
        children: [
          _checking
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _userData != null
                              ? prettyPrint(_userData!)
                              : "NO LOGGED",
                        ),
                        const SizedBox(height: 20),
                        _accessToken != null
                            ? Text(
                                prettyPrint(_accessToken!.toJson()),
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: Text(
                            _userData != null ? "LOGOUT" : "LOGIN",
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: _userData != null
                              ? _facebookLogout
                              : _facebookLogin,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                // Navigator.pushNamed(context, '/home');
                _login();
              },
              child: const Text('登录'),
            ),
          ),
        ],
      ),
    );
  }
}
