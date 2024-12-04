import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_book/componets/button.dart';
import 'package:in_book/componets/text_field.dart';


class LoginPage extends StatefulWidget {
    final Function()? onTap;
    const LoginPage({super.key, required this.onTap});

    @override
    State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    void signIn() async {
      showDialog(
        context: context, 
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text, 
          password: passwordTextController.text,
          );
        
        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code);
      }
    }

    void displayMessage(String message) {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(message),
        ),
      );
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            backgroundColor: Colors.grey[300],
            body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Icon(
                                Icons.lock,
                                size: 100,
                            ),

                            const SizedBox(height: 50),
                            // mensagem de voltar
                            Text(
                                "Bem Vindo de volta!",
                                style: TextStyle(
                                  color: Colors.grey[700]
                                ),
                            ),

                            const SizedBox(height: 25),

                            // email
                            MyTextField(
                              controller: emailTextController,
                              hintText: 'Email', 
                              obscureText: false,
                            ),

                            const SizedBox(height: 10),

                            // senha
                            MyTextField(
                              controller: passwordTextController, 
                              hintText: 'Senha', 
                              obscureText: true,
                            ),

                            const SizedBox(height: 10),

                            // botao

                            MyButton(
                              onTap: signIn, 
                              text: 'Entrar',
                            ),

                            const SizedBox(height: 25),
                            // pagina de registro

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text("Não é membro ?",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      )
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: widget.onTap,
                                      child: const Text(
                                        "Registre agora!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                        )
                                      )
                                    )
                                    
                                ]
                            )
                        ],
                    ),
                    )
                ),
            ),
        );
    }
}