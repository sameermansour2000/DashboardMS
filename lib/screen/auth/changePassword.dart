import 'package:fintech_dashboard_clone/screen/auth/widgets/gradient_button.dart';
import 'package:fintech_dashboard_clone/screen/auth/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                'Enter New Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'New Password',
                controller: pass, obscureText: true,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              GradientButton(
                onTap: () async {
                  if (pass.text.isNotEmpty) {
                    await FirebaseAuth.instance.currentUser!
                        .updatePassword(pass.text);
                    Navigator.pop(context);
                  }
                },
                title: 'Change Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
