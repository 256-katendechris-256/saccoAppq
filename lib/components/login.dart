import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sacco/components/button.dart';
import 'package:sacco/components/register.dart';
import 'package:sacco/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:sacco/components/social_button.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Service_Auth/service_file.dart';
import '../screens/home_page.dart';
import '../utils/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;//keep track of the current user
  Authentication_service? _Authentication_service;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String? _email, _password;

  @override
  void initState() {
    super.initState();
    _Authentication_service = GetIt.instance<Authentication_service>();
    _auth.authStateChanges().listen((event){
      setState(() {
        _user = event;
      });
    });
  }

  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    onSaved: (value) {
                      _email = value;
                    },
                    validator: (value) {
                      bool _results = value!.contains(
                          RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'));
                      return _results ? null : "Please enter a valid email";
                    },
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
                        ),
                      ),
                    ),
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
                    disable: false,
                  ),
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
                  /*Button(
                    width: double.infinity,
                    title: 'Google',
                    onPressed: () {
                    //  _loginUser();
                    },
                    disable: false,
                  ),*/
                  _user != null ? _userInfo() : _googleSignInButton(),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _googleSignInButton(){
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign in with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool _results = await _Authentication_service!.loginUser(email: _email!, password: _password!);
      if (_results) Navigator.popAndPushNamed(context, 'home');
    }
  }

  _userInfo() {
    return SizedBox.fromSize();
  }

  void _handleGoogleSignIn() async{
    try{
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(_googleAuthProvider);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }catch(error){
      print(error);
    }
  }
}
