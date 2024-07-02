import 'package:sacco/components/button.dart';
import 'package:sacco/utils/config.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primsryColor,
            decoration: const InputDecoration(
              hintText: 'Email address',
              labelText: 'Email address',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primsryColor,
            ),
          ),
          Config.spacesmall,
          TextFormField(
            controller: passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primsryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'password',
                labelText: 'password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primsryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primsryColor,
                          ))),
          ),
          Config.spacesmall,
          Button(
              width: double.infinity,
              title: 'Sign in',
              onPressed: () {
                Navigator.of(context).pushNamed('main');
              },
              disable: false)
        ],
      ),
    );
  }
}
