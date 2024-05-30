import 'package:fintech_dashboard_clone/screen/auth/widgets/gradient_button.dart';
import 'package:fintech_dashboard_clone/screen/auth/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Enter Your Email To change Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                controller: email, obscureText: false,
              ),
              const SizedBox(height: 15),
              isTapped
                  ? const Text(
                      'We Send A Verification Link To Your Email , Check Your Email ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 15),
              GradientButton(
                onTap: () async {
                 if(email.text.isNotEmpty){
                   setState(() {
                     isTapped = true;
                   });
                   await resetPassword(email.text);
                 }
                },
                title: 'Send Verification Link',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
