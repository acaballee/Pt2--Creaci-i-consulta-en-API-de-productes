
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'Enter Username'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter Password'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
              },
              child: Text('Login'),
            ),
          SizedBox(height: 20),
        ],
      )
    );
  }
}