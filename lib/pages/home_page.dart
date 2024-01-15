import 'package:flutter/material.dart';
import 'package:recordatoris_app/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
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
            smallGap,
            ///Text
            const Text(
              'Recordatoris App', 
              style: TextStyle(
                fontSize: 50,
                color: Colors.blue,
              ),
            ),
            largeGap,
            ///Sign In Button
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              }, 
              child: const Text('Sign-In'),
            ),
            smallGap,
            ///Sign Up Button
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              }, 
              child: const Text('Sign-Up'),
            ),
          ],
        ),
      ),
    );
  }
}