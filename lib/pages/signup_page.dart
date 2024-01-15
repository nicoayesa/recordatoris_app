import 'package:flutter/material.dart';
import 'package:recordatoris_app/utils/constant.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  /// Initialize controller for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  
  ///[createUser] function that handles user creation
  Future<bool> createUser ({
    required final String email,
    required final String password,
  }) async {
    final response = await client.auth.signUp(
      email,
      password,
    );
    
    final error = response.error;
    if (error == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///Icon
          const Icon(
              Icons.calendar_month_rounded, 
              size: 150,
              color: Colors.blue,
            ),
            largeGap,
          ///Email_Input
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
            ),
            smallGap,
            ///Password_TextIpnut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
              ),
            ),
            smallGap,
            ///RepeatPassword_TextIpnut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _repasswordController,
                decoration: const InputDecoration(label: Text('Repeat Password')),
                obscureText: true,
              ),
            ),
            largeGap,
          ///Singup Button
           OutlinedButton(
              onPressed: () async {
                if (_passwordController.text == _repasswordController.text) {
                  final userValue = await createUser(
                  email: _emailController.text, 
                  password: _passwordController.text);
                  if (userValue == true) {
                    Navigator.pushReplacementNamed(context, '/signin');
                    context.showErrorMessage('Success');
                  }
                } else {
                  context.showErrorMessage('The Passwords dosn\'t match');
                }
              }, 
              child: const Text('Sign-Up'),
            ),
        ],
      ),
    );
  }
}