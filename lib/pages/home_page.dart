import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_book/componets/drawer.dart';
import 'package:in_book/componets/text_field.dart';
import 'package:in_book/componets/wall_post.dart';
import 'package:in_book/pages/profile_page.dart';
import 'package:in_book/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

  setState(() {
    textController.clear();
  });
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
      context, MaterialPageRoute(
        builder: (context)=> const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("InBook"),
        centerTitle: true,
        backgroundColor: lightColorScheme.primary,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      drawer: MyDrawer(onProfileTap: goToProfilePage, onLogoutTap: signOut),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection("Users Posts")
                  .orderBy(
                    "TimeStamp", 
                    descending: false
                  ).snapshots(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          final post = snapshot.data!.docs[index];
                          return WallPost(
                            message: post["Message"], 
                            user: post["UserEmail"],
                            postId: post.id,
                            likes: List<String>.from(post['Likes'] ?? []),
                            );
                        },
                      );
                    } else if (snapshot.hasError){
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                ),
            ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: textController, 
                    hintText: "Whrite what are you thinking...", 
                    obscureText: false
                    ) 
                ),
            
                IconButton(
                  onPressed: postMessage, 
                  icon: const Icon(Icons.arrow_circle_up)
                ),
              ],
              ),
          ),

            Text("Logado como: ${currentUser.email!}", style: TextStyle(color: Colors.grey),),

            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

