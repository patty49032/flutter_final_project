import 'package:flutter/material.dart';
import 'package:flutter_final_project/main.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login to Employee Salary Database"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                bool res = await _service.login(
                    email: _emailController.text,
                    password: _passwordController.text);

                print(res);
                if (res) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Login Success")));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: "Employee Salary Database")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email/Password is Wrong")));
                }
              },
              child: Text("login"),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
