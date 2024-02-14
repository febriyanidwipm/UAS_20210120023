import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uaskelompok_pam/views/auth/login_screen.dart';
import 'package:uaskelompok_pam/views/navbar/navbar_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const NavbarScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
