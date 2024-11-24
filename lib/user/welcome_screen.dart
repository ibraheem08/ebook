import 'package:ebook/theme.dart';
import 'package:ebook/user/custom_scaffold.dart';
import 'package:ebook/user/signin_screen.dart';
import 'package:ebook/user/signup_screen.dart';
import 'package:ebook/user/welcome_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

bool rememberPassword = false;

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: Container(
                    color: Color.fromARGB(137, 230, 91, 79),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'Welcome Back!\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                              text:
                                  'Here you can find best book for you and you can also read book and listens book ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                // height: 0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Color(0xFFE65C4F),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
