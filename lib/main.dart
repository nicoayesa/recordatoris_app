import 'package:flutter/material.dart';
import 'package:recordatoris_app/pages/home_page.dart';
import 'package:recordatoris_app/pages/signin_page.dart';
import 'package:recordatoris_app/pages/signup_page.dart';
import 'package:recordatoris_app/pages/simpleapp_page.dart';
import 'package:recordatoris_app/utils/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url:'https://trxtizuxzaxzlcyeboll.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRyeHRpenV4emF4emxjeWVib2xsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ3MjU4MTAsImV4cCI6MjAyMDMwMTgxMH0.9tkzmEv1VXhaFTjnURT9zmKgroNdZ4J2ZriD9wulOTw',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: client.auth.currentSession != null ? '/simpleapp' : '/',
      routes: {
        '/' :(context) => const HomePage(),
        '/signin' :(context) => const SignInPage(),
        '/signup' :(context) => const SignUpPage(),
        '/simpleapp' :(context) => const SimpleAppPage(),
      },
    );
  }
}