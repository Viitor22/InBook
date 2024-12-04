import 'package:flutter/material.dart';
import 'package:in_book/pages/login_page.dart';
import 'package:in_book/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
    const LoginOrRegister({super.key});

    @override
    State<LoginOrRegister> createState() => _LoginOrRegisterState();
}


class _LoginOrRegisterState extends State<LoginOrRegister> {
  //inicialmente mostra a pg de login
  bool showLoginPage = true;

  //alterna entre login e registro
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    }else {
      return RegisterPage(onTap: togglePages);
    }
  }
}