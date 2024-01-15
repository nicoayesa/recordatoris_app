import 'package:flutter/material.dart';
import 'package:recordatoris_app/utils/constant.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  /// Initialize controller for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  ///[userLogin] function that handles the login
  Future<String?> userLogin({
    required final String email,
    required final String password,
  }) async {
    final response = await client.auth.signIn(
      email: email,
      password: password,
    );
    final user = response.data?.user;
    return user?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Icon
            const Icon(
              Icons.calendar_month_rounded,
              size: 150,
              color: Colors.blue,
            ),
            largeGap,
            ///Email_TextInput
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
            largeGap,
            ///Sign In Button
            isLoading ? Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ):
            OutlinedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                dynamic loginValue = await userLogin(
                  email: _emailController.text, 
                  password: _passwordController.text
                );
                setState(() {
                  isLoading = false;
                });
                if (loginValue != null) {
                  Navigator.pushReplacementNamed(context, '/simpleapp',);
                } else {
                  context.showErrorMessage('Invalid Email or Password.');
                }
              }, 
              child: const Text('Sign-In'),
            ),
          ],
        ),
      ),
    );
  }
}