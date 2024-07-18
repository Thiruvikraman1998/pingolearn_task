import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';
import 'package:pingolearn_task_app/viewmodels/auth_viewmodels/auth_viewmodel.dart';
import 'package:pingolearn_task_app/views/auth/login_page.dart';
import 'package:pingolearn_task_app/widgets/custom_button.dart';
import 'package:pingolearn_task_app/widgets/custom_text_field.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/loading_widget_provider.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/ui_provider.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TapGestureRecognizer _loginPage = TapGestureRecognizer();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loginPage.onTap = () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    };
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.02),
          child: Column(
            children: [
              Expanded(
                flex: 1,
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
                flex: 2,
                child: Form(
                  key: _formKey,
                  child: Consumer<UiProvider>(
                    builder: (context, uiProvider, child) => Column(
                      children: [
                        CustomTextField(
                          textController: _userNameController,
                          labelText: "Name",
                        ),
                        Gap(size.height * 0.02),
                        CustomTextField(
                          textController: _emailController,
                          labelText: "Email",
                        ),
                        Gap(size.height * 0.02),
                        CustomTextField(
                          textController: _passwordController,
                          labelText: "Password",
                          textObscure: uiProvider.isPasswordObscured,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                uiProvider.togglePasswordVisibility(),
                            icon: !uiProvider.isPasswordObscured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Gap(size.height * 0.1),
              Column(
                children: [
                  Consumer<FirebaseAuthProvider>(
                    builder: (context, auth, child) => CustomButton(
                      onButtonPressed: () {
                        auth.signup(
                            _userNameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            context);
                      },
                      buttonBodyWidget: auth.isLoading == true
                          ? const CircularProgressIndicator(
                              color: AppTheme.secondaryColor,
                            )
                          : const Text(
                              "SingUp",
                              style: TextStyle(color: AppTheme.secondaryColor),
                            ),
                    ),
                  ),
                  Gap(size.height * 0.02),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                          ),
                          recognizer: _loginPage,
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
