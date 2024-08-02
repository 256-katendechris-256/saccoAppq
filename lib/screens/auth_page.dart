import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sacco/components/login.dart';
import 'package:sacco/components/register.dart';
import 'package:sacco/components/social_button.dart';
import 'package:sacco/screens/home_page.dart';
import 'package:sacco/utils/config.dart';
import 'package:sacco/utils/text.dart';
import '../Service_Auth/service_file.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Authentication_service? _authenticationService;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authenticationService = GetIt.instance<Authentication_service>();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppText.enText?['welcome_text'] ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spacesmall,
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text(
                        AppText.enText?['signIn_text'] ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Config.spacesmall,
                  const Login(),
                  Config.spacesmall,
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // forgot password logic
                      },
                      child: Text(
                        AppText.enText?['forgot_password'] ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SocialButton(social: 'phone'),
                          SocialButton(social: 'google'),
                        ],
                      ),
                      Config.spacesmall,
                      Center(
                        child: Text(
                          AppText.enText?['no_account'] ?? '',
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
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                            // sign up logic
                          },
                          child: Text(
                            AppText.enText?['signup_text'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
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
