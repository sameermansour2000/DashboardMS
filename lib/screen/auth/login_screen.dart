import 'package:fintech_dashboard_clone/main.dart';
import 'package:fintech_dashboard_clone/screen/auth/widgets/gradient_button.dart';
import 'package:fintech_dashboard_clone/screen/auth/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgetPassword.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                controller: email,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                controller: pass,
              ),
              const SizedBox(height: 20),
              GradientButton(
                onTap: () => login(email.text, pass.text).then((value) {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                }),
                title: 'Sign in',
              ),
              const SizedBox(height: 5),
              GradientButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ForgetPassword()));
                },
                title: 'Forget password ...?',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(String email, pass) async {
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        print(userCredential);
        return userCredential;
      } else {
        print('isEmpty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user-not-found');
      } else if (e.code == 'wrong-password') {
        print('wrong-password');
      }
    } catch (e) {
      print(e);
    }
  }
}
