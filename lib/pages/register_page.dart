import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:in_book/componets/button.dart';
import 'package:in_book/pages/login_page.dart';
import 'package:in_book/theme/theme.dart';


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

    bool agreePersonalData = true;
    bool _passwordVisible = false;
    bool _confirmPasswordVisible = false;


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
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text, 
          password: passwordTextController.text,
        );

        FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
            'username' : emailTextController.text.split('@')[0],
            'bio' : 'Empty bio...'
          });
        
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
                            Icon(
                                Icons.lock,
                                size: 100,
                                color: lightColorScheme.primary,
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
                            TextFormField(
                              controller: emailTextController,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress, // Corrigido
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                hintText: 'Enter Email',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // senha
                            TextFormField(
                              controller: passwordTextController, 
                              obscureText: !_passwordVisible,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.text, // Corrigido
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Password'),
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black26,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            //confirmação de senha
                            TextFormField(
                              controller: confirmPasswordTextController, 
                              obscureText: !_confirmPasswordVisible,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.text, // Corrigido
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm Password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Confirm Password'),
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black26,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordVisible = !_confirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // botao
                            MyButton(
                              onTap: signUp, 
                              text: 'Cadastrar',
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(onTap: widget.onTap)
                                          ),
                                        );
                                      },
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
