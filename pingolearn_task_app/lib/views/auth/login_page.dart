import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';
import 'package:pingolearn_task_app/views/auth/signup.dart';
import 'package:pingolearn_task_app/widgets/custom_button.dart';
import 'package:pingolearn_task_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodels/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TapGestureRecognizer _signupPage = TapGestureRecognizer();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    _signupPage.onTap = () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Signup(),));};
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.02),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "MyNews",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        textController: _emailController,
                        labelText: "Email",
                      ),
                      Gap(size.height * 0.02),
                      CustomTextField(
                        textController: _passwordController,
                        labelText: "Password",
                      )
                    ],
                  ),
                ),
              ),
              Gap(size.height * 0.1),
              Column(
                children: [
                  Consumer<FirebaseAuthProvider>(
                    builder: (context, authProvider, child) => CustomButton(
                      onButtonPressed: () {
                        authProvider.login(_emailController.text.trim(),
                            _passwordController.text.trim(),context);
                      },
                      buttonBodyWidget: const Text("Login",style: TextStyle(color: AppTheme.secondaryColor),),
                    ),
                  ),
                  Gap(size.height * 0.02),
                  RichText(
                    text: TextSpan(
                      text: "New here? ",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Signup",
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                          ),
                          recognizer: _signupPage,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
