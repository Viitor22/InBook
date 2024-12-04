import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:in_book/componets/button.dart';
import 'package:in_book/componets/text_field.dart';


class RegisterPage extends StatefulWidget {
    final Function()? onTap;
    const RegisterPage({super.key, required this.onTap});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final confirmPasswordTextController = TextEditingController();

  void signUp() async {
      showDialog(
        context: context, 
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
      );

      if(passwordTextController.text != confirmPasswordTextController.text) {
        Navigator.pop(context);
        displayMessage("As senhas não são iguais");
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                                "Vamos criar uma conta!",
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

                            //confirmação de senha
                            MyTextField(
                              controller: confirmPasswordTextController, 
                              hintText: 'Confirmar Senha', 
                              obscureText: true,
                            ),

                            const SizedBox(height: 10),

                            // botao
                            MyButton(
                              onTap: signUp, 
                              text: 'Entrar',
                            ),

                            const SizedBox(height: 25),
                            // pagina de registro

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text("Já é um membro ?",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      )
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: widget.onTap,
                                      child: const Text(
                                        "Entre aqui!",
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
