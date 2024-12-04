import 'package:flutter/material.dart';
import 'package:in_book/componets/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
// User

  Future<void> editField(String field) async{

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Profile page'),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // foto de perfil
          Icon(
            Icons.person,
            size: 72,
          ),

          // user details
        Padding(padding: const EdgeInsets.only(left: 25.0),
        child: Text(
          'Mu datails',
          style: TextStyle(color: Colors.grey[600]),

        )),


          // username
MyTextBox(
  text: " from bio", 
  sectionName: "Nickname",
  onPressed: () => editField('Nickname')),
          
          // bio
MyTextBox(
  text: 'empty bio',
  sectionName: 'bio',
  onPressed: () => editField('bio')
),

    const SizedBox(height: 50),

          // user posts

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Posts',
              style: TextStyle(color: Colors.grey[600]),
            )
          )
        ],
      ),
    );
  }
}
