import 'package:flutter/material.dart';
import 'package:sacco/components/button.dart';
import 'package:sacco/screens/auth_page.dart';
import 'package:sacco/utils/config.dart';
import 'package:sacco/utils/text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppText.enText?['register_text'] ?? 'Register',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spacesmall,
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: AppText.enText?['username_text'] ?? 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  Config.spacesmall,
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppText.enText?['email_text'] ?? 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  Config.spacesmall,
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: AppText.enText?['password_text'] ?? 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Config.spacesmall,
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: AppText.enText?['confirm_password_text'] ??
                          'Confirm Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Config.spacesmall,
                  Button(
                      width: double.infinity,
                      title: 'Sign Up',
                      onPressed: () {
                        Navigator.of(context).pushNamed('main');
                      },
                      disable: false),
                  Config.spacesmall,
                  Center(
                    child: Text(
                      AppText.enText?['registered_text'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AuthPage()),
                        );
                        // sign up logic
                      },
                      child: Text(
                        AppText.enText?['signIn_text'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
