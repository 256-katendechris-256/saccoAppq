import 'package:get_it/get_it.dart';
import 'package:sacco/components/button.dart';
import 'package:sacco/utils/config.dart';
import 'package:flutter/material.dart';

import '../Service_Auth/service_file.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Authentication_service? _Authentication_service;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String? _email, _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Authentication_service = GetIt.instance<Authentication_service>();
  }

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
              onSaved: (value){
               _email= value;
              },
              validator:(value){
                bool _results = value!.contains(
                    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'));
                return _results ? null : "Please enter a valid email";
              }
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
            onSaved: (value) {
              _password = value;
            },
            validator: (value) =>
            value!.length > 6 ? null : "Please enter a password with at least six characters",
            enableInteractiveSelection: true,

          ),
          Config.spacesmall,


          Button(
              width: double.infinity,
              title: 'Sign in',
              onPressed: () {
                _loginUser();
              },
              disable: false)
        ],
      ),
    );
  }



  _loginUser() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      bool _results = await _Authentication_service!.loginUser(email: _email!, password: _password!);
      if(_results) Navigator.popAndPushNamed(context, 'home');

    }
  }
}
