import 'package:flutter/material.dart';
import 'package:open_cart/screens/login_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/form_validators.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/auth_page_header_widget.dart';
import 'package:open_cart/widgets/auth_page_register_button_widget.dart'; 
import 'package:open_cart/widgets/signup_text_button_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colorDarkGrey,
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(
                header: 'Register',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        style: tsCwhiteFFPrimaryS15,
                        controller: emailController,
                        validator: (value) => validateEmail(value),
                        decoration: InputDecoration(
                          fillColor: colorGrey700,
                          filled: true,
                          labelStyle: tsCwhiteFFPrimaryS15,
                          border: OutlineInputBorder(borderRadius: bRC30),
                          label: const Text('Email'),
                        ),
                      ),
                      const SBH20(),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        style: tsCwhiteFFPrimaryS15,
                        controller: passwordController,
                        validator: (value) => validatePassword(value),
                        decoration: InputDecoration(
                          fillColor: colorGrey700,
                          filled: true,
                          labelStyle: tsCwhiteFFPrimaryS15,
                          border: OutlineInputBorder(borderRadius: bRC30),
                          label: const Text('Password'),
                        ),
                      ),
                      const SBH30(),
                      RegisterButtonWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: _formKey)
                    ],
                  ),
                ),
              ),
              const SignuporinTextButtonWidget(
                authMethod: 'Login',
                text1: 'Already have an account?',
                route: LoginScreen.route,
              )
            ],
          ),
        ),
      ),
    );
  }
}